//
//  MetooScrollerFootView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/25.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol MetooFootDelegate {
    func downLoadImage()
}
class MetooScrollerFootView: UIView {
    var delegate: MetooFootDelegate?
    
    var isShow: Bool = true
    var likesBtn: UIButton?
    var downLoadBtn:UIButton?
    var reportBtn: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
         createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI(){
        self.alpha = 0.6
        self.backgroundColor = .black
        let likesBtn = UIButton(type: .custom)
        likesBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        likesBtn.setTitle("点赞", for: .normal)
        likesBtn.addTarget(self, action: #selector(likesBtnClick), for: .touchUpInside)
        self.addSubview(likesBtn)
        likesBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        self.likesBtn = likesBtn
        let downLoadBtn = UIButton(type: .custom)
        downLoadBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        downLoadBtn.setTitle("下载", for: .normal)
        downLoadBtn.addTarget(self, action: #selector(downLoadBtnClick), for: .touchUpInside)
        self.addSubview(downLoadBtn)
        downLoadBtn.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(self)
        }
        self.downLoadBtn = downLoadBtn
        let reportBtn = UIButton(type: .custom)
        reportBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        reportBtn.setTitle("举报", for: .normal)
        reportBtn.addTarget(self, action: #selector(reportBtnClick), for: .touchUpInside)
        self.addSubview(reportBtn)
        reportBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
        self.reportBtn = reportBtn
    }
    @objc func likesBtnClick(){
        
    }
    @objc func downLoadBtnClick(){
        if self.delegate != nil {
            self.delegate?.downLoadImage()
        }
    }
    @objc func reportBtnClick(){
        
    }
    func hideFootView(){
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: 60)
        }
        self.layoutIfNeeded()
        self.isShow = !self.isShow
    }
    func showFootView(){
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: screenHeight-60, width: screenWidth, height: 60)
        }
        self.layoutIfNeeded()
        self.isShow = !self.isShow
    }
}
