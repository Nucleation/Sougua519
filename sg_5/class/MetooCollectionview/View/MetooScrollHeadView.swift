//
//  MetooScrollHeadView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/25.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
typealias backBlock = () -> Void
class MetooScrollHeadView: UIView {
    var backBtn: UIButton?
    var titleLab: UILabel?
    
    var backBlock: backBlock?
    var isShow: Bool = true
    
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
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui1"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.addSubview(backBtn)
        self.backBtn = backBtn
        let titlelab = UILabel()
        titlelab.textAlignment = .center
        titlelab.font = UIFont.systemFont(ofSize: 14)
        titlelab.numberOfLines = 1
        titlelab.textColor = .white
        self.addSubview(titlelab)
        self.titleLab = titlelab
        
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.width.equalTo(40)
            make.height.equalTo(self).offset(-20)
            make.left.equalTo(self)
        }
        titlelab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(self).offset(-120)
            make.centerY.height.equalTo(backBtn)
        }
       
    }
    @objc func backBtnClick() {
        if backBlock != nil {
            backBlock!()
        }
    }
    func backBlock(block: @escaping () -> Void) {
        backBlock = block
    }
    func hideHeadView(){
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: -60, width: screenWidth, height: 60)
        }
        self.layoutIfNeeded()
        self.isShow = !self.isShow
    }
    func showHeadView(){
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
        }
        self.layoutIfNeeded()
        self.isShow = !self.isShow
    }
}
