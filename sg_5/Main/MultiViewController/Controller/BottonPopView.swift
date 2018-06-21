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
        reloadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        reloadBtn.titleLabel?.textAlignment = .center
        reloadBtn.setImage(UIImage(named: "bottom刷新"), for: .normal)
        reloadBtn.setTitle("刷新", for: .normal)
        reloadBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        reloadBtn.addTarget(self, action: #selector(reloadBtnClick), for: .touchUpInside)
        self.addSubview(reloadBtn)
        self.reloadBtn = reloadBtn
        let copyBtn = UIButton(type: .custom)
        copyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        copyBtn.titleLabel?.textAlignment = .center
        copyBtn.setImage(UIImage(named: "bottom复制链接"), for: .normal)
        copyBtn.setTitle("复制链接", for: .normal)
        copyBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        copyBtn.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.addSubview(copyBtn)
        self.copyBtn = copyBtn
        let openWebBtn = UIButton(type: .custom)
        openWebBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        openWebBtn.titleLabel?.textAlignment = .center
        openWebBtn.setImage(UIImage(named: "bottom浏览器打开"), for: .normal)
        openWebBtn.setTitle("浏览器打开", for: .normal)
        openWebBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        openWebBtn.addTarget(self, action: #selector(openWebBtnClick), for: .touchUpInside)
        self.addSubview(openWebBtn)
        self.openWebBtn = openWebBtn
        let shareBtn = UIButton(type: .custom)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        shareBtn.titleLabel?.textAlignment = .center
        shareBtn.setImage(UIImage(named: "bottom分享"), for: .normal)
        shareBtn.setTitle("分享", for: .normal)
        shareBtn.setTitleColor(UIColor.colorWithHexColorString("666666"), for: .normal)
        shareBtn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        self.addSubview(shareBtn)
        self.shareBtn = shareBtn
        self.reloadBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.centerX.equalTo(self.snp.centerX).offset(-self.width * 3/8)
            make.width.equalTo(80)
            make.centerY.equalTo(self).offset(0)
        })
        self.copyBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.centerX.equalTo(self.snp.centerX).offset(-self.width/8)
            make.width.equalTo(80)
            make.centerY.equalTo(self).offset(0)
        })
        self.openWebBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.centerX.equalTo(self.snp.centerX).offset(self.width/8)
            make.width.equalTo(80)
            make.centerY.equalTo(self).offset(0)
        })
        self.shareBtn?.snp.makeConstraints({ (make) in
            make.height.equalTo(self)
            make.centerX.equalTo(self.snp.centerX).offset(self.width * 3/8)
            make.width.equalTo(80)
            make.centerY.equalTo(self).offset(0)
        })
        self.layoutIfNeeded()
        reloadBtn.titleEdgeInsets = UIEdgeInsets(top: reloadBtn.imageView!.frame.size.height, left: -reloadBtn.imageView!.frame.size.width, bottom: 0, right: 0)
        reloadBtn.imageEdgeInsets = UIEdgeInsets(top: -reloadBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -reloadBtn.titleLabel!.bounds.size.width)
        copyBtn.titleEdgeInsets = UIEdgeInsets(top: copyBtn.imageView!.frame.size.height, left: -copyBtn.imageView!.frame.size.width-10, bottom: 0, right: 0)
        copyBtn.imageEdgeInsets = UIEdgeInsets(top: -copyBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -40)
        openWebBtn.titleEdgeInsets = UIEdgeInsets(top: openWebBtn.imageView!.frame.size.height, left: -openWebBtn.imageView!.frame.size.width+10, bottom: 0, right: 0)
        openWebBtn.imageEdgeInsets = UIEdgeInsets(top: -openWebBtn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -70)
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
