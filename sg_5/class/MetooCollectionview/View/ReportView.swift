//
//  ReportView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/25.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class ReportView: UIView {
    var contentId: String?
    var centerView: UIView?
    var numberLab: UILabel?
    var sendBtn: UIButton?
    var reportArray: Array<UIButton> = [UIButton]()
    var reportTitleArr: Array<String> = ["内容低俗","广告","标题夸张","色情或暴力","显示或播放问题","抄袭","散播谣言"]
    var lastBtn: UIButton?
    var selectNum = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.9
        self.backgroundColor = .black
        createUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
        let centerView = UIView()
        centerView.backgroundColor = .white
        centerView.alpha = 1
        self.addSubview(centerView)
        self.centerView = centerView
        let numberLab = UILabel()
        numberLab.text = "已选择0个理由"
        numberLab.font = UIFont.systemFont(ofSize: 16)
        self.centerView?.addSubview(numberLab)
        self.numberLab = numberLab
        let sendBtn = UIButton(type: .custom)
        sendBtn.backgroundColor = UIColor.colorWithHexColorString("adccf9")
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendBtn.setTitle("确认", for: .normal)
        sendBtn.layer.cornerRadius = 5
        sendBtn.addTarget(self, action: #selector(sendReport), for: .touchUpInside)
        self.centerView?.addSubview(sendBtn)
        self.sendBtn = sendBtn
        self.numberLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.centerView!).offset(20)
            make.top.equalTo(self.centerView!).offset(20)
            make.height.equalTo(30)
        })
        self.sendBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.centerView!).offset(-20)
            make.centerY.height.equalTo(self.numberLab!)
            make.width.equalTo(50)
        })
        for i in 0 ..< self.reportTitleArr.count {
            let reportBtn = UIButton(type: .custom)
            reportBtn.layer.borderColor = UIColor.black.cgColor
            reportBtn.layer.borderWidth = 1.0
            reportBtn.layer.cornerRadius = 5
            reportBtn.tag = i + 100
            reportBtn.showsTouchWhenHighlighted = true
            reportBtn.isSelected = false
            reportBtn.setTitle(self.reportTitleArr[i], for: .normal)
            reportBtn.setTitleColor(UIColor.colortext1, for: .normal)
            reportBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            reportBtn.addTarget(self, action: #selector(reportBtnClick(sender:)), for: .touchUpInside)
            self.addSubview(reportBtn)
            reportBtn.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.width.equalTo((screenWidth-140)/2)
                if self.lastBtn != nil {
                    if i % 2 == 0 {
                        make.top.equalTo(self.lastBtn!.snp.bottom).offset(20)
                        make.left.equalTo(self.centerView!).offset(20)
                    }else{
                        make.top.equalTo(self.lastBtn!)
                        make.right.equalTo(self.centerView!).offset(-20)
                    }
                }else{
                    make.top.equalTo(self.numberLab!.snp.bottom).offset(20)
                    make.left.equalTo(self.centerView!).offset(20)
                }
                self.reportArray.append(reportBtn)
            }
           self.lastBtn = reportBtn
        }
        self.centerView?.snp.remakeConstraints({ (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(screenWidth-60)
            make.bottom.equalTo(self.lastBtn!).offset(20)
        })
    }
    @objc func reportBtnClick(sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.layer.borderColor = UIColor.colorAccent.cgColor
            sender.setTitleColor(UIColor.colorAccent, for: .normal)
        }else{
            sender.layer.borderColor = UIColor.colortext1.cgColor
            sender.setTitleColor(UIColor.colortext1, for: .normal)
        }
        self.selectNum = 0
        for i in 0 ..< self.reportTitleArr.count {
            let btn = sender.superview?.viewWithTag(100 + i) as! UIButton
            if btn.isSelected == true{
                self.selectNum += 1
            }
        }
        if self.selectNum != 0 {
            self.sendBtn?.backgroundColor = UIColor.colorAccent
        }else{
            self.sendBtn?.backgroundColor = UIColor.colorWithHexColorString("adccf9")
        }
        self.numberLab?.text = "已选择\(self.selectNum)个理由"
        self.layoutIfNeeded()
    }
    @objc func sendReport(){
        var reportReasonArr:Array <String> = [String]()
        for i in self.reportArray {
            if i.isSelected == true{
                reportReasonArr.append(self.reportArray[i.tag - 100].titleLabel?.text ?? "")
            }
        }
        let reportReason = reportReasonArr.map {"\($0)"}.joined(separator: ",")
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"contentId":self.contentId! ,"contentType":ContentType.Picture.rawValue,"reportReason":reportReason,"userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!,"mobile":KeyChain().getKeyChain()["mobile"]!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: commentReportUrl, parameters: parData ) { (json) in
            self.makeToast("举报成功", point: self.center, title: nil, image: nil, completion: nil)

             self.removeFromSuperview()
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
}
