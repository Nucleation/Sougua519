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
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.width.equalTo(40)
            make.height.equalTo(self).offset(-20)
            make.left.equalTo(self)
        }
        self.backBtn = backBtn
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
