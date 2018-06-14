//
//  CommentView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/29.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import Toast_Swift
protocol CommentViewDelegate {
    func reloadComment()
}
class CommentView: UIView {
    var delegate:CommentViewDelegate?
    var textField: UITextField?
    var sendBtn: UIButton?
    var novelInfo:NoveCategoryListModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.placeholder = "请输入评论"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        textField.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textField)
        self.textField = textField
        let sendBtn = UIButton(type: .custom)
        sendBtn.backgroundColor = .colorAccent
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendBtn.setTitle("评论", for: .normal)
        sendBtn.layer.cornerRadius = 5
        sendBtn.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        self.addSubview(sendBtn)
        self.sendBtn = sendBtn
        self.textField?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(self).offset(-20)
            make.right.equalTo(self.sendBtn!.snp.left).offset(-10)
        })
        self.sendBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.textField!)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(self).offset(-20)
            make.width.equalTo(60)
        })
    }
    @objc func sendComment() {
        if self.textField?.text == "" {
            return
        }
        let keyChain = KeyChain()
        guard let mobile = keyChain.getKeyChain()["mobile"],let token = keyChain.getKeyChain()["token"],let id = keyChain.getKeyChain()["id"] else {
            self.makeToast("你还没有登录")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"typeId":self.novelInfo?.id ?? "","mobile":mobile,"token":token,"fromId":id,"type":ContentType.Novel.rawValue,"content":self.textField?.text ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: addCommentUrl, parameters: parData) { (json) in
            print("\(json)--add")
            self.makeToast(json["msg"].stringValue)
            if self.delegate != nil {
                self.delegate?.reloadComment()
            }
        }
    }
    
}
