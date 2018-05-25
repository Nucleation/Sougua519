//
//  NovelHomeHeadView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

protocol NovelHeadViewDelegate {
    func bookCityClick()
    func bookshelfClick()
    func backBtnClick()
}
class NovelHomeHeadView: UIView {
    var delegate: NovelHeadViewDelegate?    
    var bookshelf: UIButton?
    var bookCity: UIButton?
    var underLineView: UIView?
    var backBtn: UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI(){
        self.backgroundColor = UIColor.white
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.addSubview(backBtn)
        self.backBtn = backBtn
        let bookshelf = UIButton(type: .custom)
        bookshelf.setTitle("书架", for: .normal)
        bookshelf.addTarget(self, action: #selector(bookshelfBtnClick(sender: )), for: .touchUpInside)
        bookshelf.isSelected = false
        bookshelf.setTitleColor(UIColor.black, for: .normal)
        bookshelf.setTitleColor(UIColor.blue, for: .selected)
        bookshelf.backgroundColor = UIColor.white
        self.addSubview(bookshelf)
        self.bookshelf = bookshelf
        let bookCity = UIButton(type: .custom)
        bookCity.setTitle("书城", for: .normal)
        bookCity.isSelected = true
        bookCity.addTarget(self, action: #selector(bookCityBtnClick(sender: )), for: .touchUpInside)
        bookCity.setTitleColor(UIColor.black, for: .normal)
        bookCity.setTitleColor(UIColor.blue, for: .selected)
        bookCity.backgroundColor = UIColor.white
        self.addSubview(bookCity)
        self.bookCity = bookCity
        let underLineView = UIView()
        underLineView.backgroundColor = UIColor.blue
        self.addSubview(underLineView)
        self.underLineView = underLineView
        self.backBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self).offset(10)
            make.width.height.equalTo(44)
            make.left.equalTo(self)
        })
        self.bookshelf?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self).offset(10)
            make.width.equalTo(50)
            make.centerX.equalTo(self).offset(25)
        })
        self.bookCity?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self).offset(10)
            make.width.equalTo(self.bookshelf!)
            make.centerX.equalTo(self).offset(-25)
        })
        self.underLineView?.snp.makeConstraints({ (make) in
            make.width.equalTo(self.bookCity!)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
            make.left.equalTo(self.bookCity!)
        })
    }
    @objc func bookCityBtnClick(sender: UIButton) {
        delegate?.bookCityClick()
        sender.isSelected = true
        self.bookshelf?.isSelected = false
        self.underLineView?.snp.remakeConstraints({ (make) in
            make.left.equalTo(self.bookCity!)
            make.width.equalTo(self.bookCity!)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    }
    @objc func bookshelfBtnClick(sender: UIButton) {
        delegate?.bookshelfClick()
        sender.isSelected = true
        self.bookCity?.isSelected = false
        self.underLineView?.snp.remakeConstraints({ (make) in
            make.left.equalTo(self.bookshelf!)
            make.width.equalTo(self.bookshelf!)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    }
    @objc func backBtnClick(){
        delegate?.backBtnClick()
    }
}
