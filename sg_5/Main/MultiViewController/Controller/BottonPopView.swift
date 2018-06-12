//
//  BottonPopView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/8.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol BottonPopViewDelegate {
    func reloadBtnClick()
    func copyBtnClick()
    func openWebClick()
    func shareBtnClick()
}
class BottonPopView: UIView {
    var reloadBtn: UIButton?
    var copyBtn: UIButton?
    var openWebBtn: UIButton?
    var shareBtn: UIButton?
    var delegate: BottonPopViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
        let reloadBtn = UIButton(type: .custom)
        reloadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        reloadBtn.setImage(UIImage(named: "bottom刷新"), for: .normal)
        reloadBtn.setTitle("刷新", for: .normal)
        reloadBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        reloadBtn.addTarget(self, action: #selector(reloadBtnClick), for: .touchUpInside)
        self.addSubview(reloadBtn)
        self.reloadBtn = reloadBtn
        let copyBtn = UIButton(type: .custom)
        copyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        copyBtn.setImage(UIImage(named: "bottom复制链接"), for: .normal)
        copyBtn.setTitle("复制", for: .normal)
        copyBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        copyBtn.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.addSubview(copyBtn)
        self.copyBtn = copyBtn
        let openWebBtn = UIButton(type: .custom)
        openWebBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        openWebBtn.setImage(UIImage(named: "bottom浏览器打开"), for: .normal)
        openWebBtn.setTitle("浏览", for: .normal)
        openWebBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        openWebBtn.addTarget(self, action: #selector(openWebBtnClick), for: .touchUpInside)
        self.addSubview(openWebBtn)
        self.openWebBtn = openWebBtn
        let shareBtn = UIButton(type: .custom)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        shareBtn.setImage(UIImage(named: "bottom分享"), for: .normal)
        shareBtn.setTitle("分享", for: .normal)
        shareBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        shareBtn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        self.addSubview(shareBtn)
        self.shareBtn = shareBtn
        self.reloadBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.left.equalTo(self).offset(25)
            make.width.equalTo((self.width - 125)/4)
            make.centerY.equalTo(self).offset(0)
        })
        self.copyBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.left.equalTo(self.reloadBtn!.snp.right).offset(25)
            make.width.equalTo((self.width - 125)/4)
            make.centerY.equalTo(self).offset(0)
        })
        self.openWebBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.left.equalTo(self.copyBtn!.snp.right).offset(25)
            make.width.equalTo((self.width - 125)/4)
            make.centerY.equalTo(self).offset(0)
        })
        self.shareBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.left.equalTo(self.openWebBtn!.snp.right).offset(25)
            make.width.equalTo((self.width - 125)/4)
            make.centerY.equalTo(self).offset(0)
        })
        self.layoutIfNeeded()
        reloadBtn.titleEdgeInsets = UIEdgeInsets(top: reloadBtn.imageView!.frame.size.height, left: -reloadBtn.imageView!.frame.size.width, bottom: 0, right: 0)
        reloadBtn.imageEdgeInsets = UIEdgeInsets(top: -reloadBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -reloadBtn.titleLabel!.bounds.size.width)
        copyBtn.titleEdgeInsets = UIEdgeInsets(top: copyBtn.imageView!.frame.size.height, left: -copyBtn.imageView!.frame.size.width, bottom: 0, right: 0)
        copyBtn.imageEdgeInsets = UIEdgeInsets(top: -copyBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -copyBtn.titleLabel!.bounds.size.width)
        openWebBtn.titleEdgeInsets = UIEdgeInsets(top: openWebBtn.imageView!.frame.size.height, left: -openWebBtn.imageView!.frame.size.width, bottom: 0, right: 0)
        openWebBtn.imageEdgeInsets = UIEdgeInsets(top: -openWebBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -openWebBtn.titleLabel!.bounds.size.width)
        shareBtn.titleEdgeInsets = UIEdgeInsets(top: shareBtn.imageView!.frame.size.height, left: -shareBtn.imageView!.frame.size.width, bottom: 0, right: 0)
        shareBtn.imageEdgeInsets = UIEdgeInsets(top: -shareBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -shareBtn.titleLabel!.bounds.size.width)
    }
    
    @objc func reloadBtnClick(){
        if self.delegate != nil {
            delegate?.reloadBtnClick()
        }
    }
    @objc func copyBtnClick(){
        if self.delegate != nil {
            delegate?.copyBtnClick()
        }
    }
    @objc func openWebBtnClick(){
        if self.delegate != nil {
            delegate?.openWebClick()
        }
    }
    @objc func shareBtnClick(){
        if self.delegate != nil {
            delegate?.shareBtnClick()
        }
    }
}
