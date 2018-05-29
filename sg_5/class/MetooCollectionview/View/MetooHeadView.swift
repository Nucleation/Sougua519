//
//  MetooHeadView.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/5/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MetooHeadView: UIView {
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var titleLabel: UILabel?
//    var newBtn: UIButton?
//    var hotBtn: UIButton?
//    var underLineView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI(){
        self.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor  = .colorAccent
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "wode"), for: .normal)
        leftBtn.backgroundColor = UIColor.white
        self.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "souzuo"), for: .normal)
        rightBtn.backgroundColor = UIColor.white
        self.addSubview(rightBtn)
        self.rightBtn = rightBtn
//        let newBtn = UIButton(type: .custom)
//        newBtn.setTitle("最新", for: .normal)
//        newBtn.addTarget(self, action: #selector(newBtnClick(sender: )), for: .touchUpInside)
//        newBtn.isSelected = true
//        newBtn.setTitleColor(UIColor.black, for: .normal)
//        newBtn.setTitleColor(UIColor.blue, for: .selected)
//        newBtn.backgroundColor = UIColor.white
//        self.addSubview(newBtn)
//        self.newBtn = newBtn
//        let hotBtn = UIButton(type: .custom)
//        hotBtn.setTitle("最热", for: .normal)
//        hotBtn.isSelected = false
//        hotBtn.addTarget(self, action: #selector(hotBtnClick(sender: )), for: .touchUpInside)
//        hotBtn.setTitleColor(UIColor.black, for: .normal)
//        hotBtn.setTitleColor(UIColor.blue, for: .selected)
//        hotBtn.backgroundColor = UIColor.white
//        self.addSubview(hotBtn)
//        self.hotBtn = hotBtn
//        let underLineView = UIView()
//        underLineView.backgroundColor = UIColor.blue
//        self.addSubview(underLineView)
//        self.underLineView = underLineView
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
        })
        self.leftBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(19)
            make.bottom.equalTo(self).offset(-15)
            make.width.height.equalTo(30)
        })
//        self.newBtn?.snp.makeConstraints({ (make) in
//            make.centerY.equalTo(self.leftBtn!)
//            make.width.equalTo(50)
//            make.centerX.equalTo(self).offset(-25)
//        })
//        self.hotBtn?.snp.makeConstraints({ (make) in
//            make.centerY.equalTo(self.leftBtn!)
//            make.width.equalTo(self.newBtn!)
//            make.centerX.equalTo(self).offset(25)
//        })
        self.rightBtn?.snp.makeConstraints({ (make) in
            make.centerY.size.equalTo(self.leftBtn!)
            make.right.equalTo(self).offset(-19)
        })
//        self.underLineView?.snp.makeConstraints({ (make) in
//            make.width.equalTo(self.newBtn!)
//            make.bottom.equalTo(self).offset(-1)
//            make.height.equalTo(1)
//            make.left.equalTo(self.newBtn!)
//        })
    }
//    @objc func newBtnClick(sender: UIButton) {
//        sender.isSelected = true
//        self.hotBtn?.isSelected = false
//        self.underLineView?.snp.remakeConstraints({ (make) in
//            make.left.equalTo(self.newBtn!)
//            make.width.equalTo(self.newBtn!)
//            make.bottom.equalTo(self).offset(-1)
//            make.height.equalTo(1)
//        })
//    }
//    @objc func hotBtnClick(sender: UIButton) {
//        sender.isSelected = true
//        self.newBtn?.isSelected = false
//        self.underLineView?.snp.remakeConstraints({ (make) in
//            make.left.equalTo(self.hotBtn!)
//            make.width.equalTo(self.newBtn!)
//            make.bottom.equalTo(self).offset(-1)
//            make.height.equalTo(1)
//        })
//    }
}
