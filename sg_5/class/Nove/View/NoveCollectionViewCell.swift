//
//  NoveCollectionViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NoveCollectionViewCell: UICollectionViewCell {
    var noveImageView: UIImageView?
    var noveTitle: UILabel?
    var noveAuthor: UILabel?
    var noveCategoty: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCellWithModel(model: NoveCategoryListModel){
        self.noveImageView?.kf.setImage(with: URL(string:"\(model.fictionImg)"))
        self.noveTitle?.text = model.fictionName
        self.noveAuthor?.text = model.fictionIsEnd
        self.noveCategoty?.text = "作者:\(model.fictionAuthor)"
    }
    func setUI(){
        noveImageView = UIImageView(image: UIImage(named: "333"))
        noveImageView?.layer.masksToBounds = true
        //imageView?.backgroundColor = UIColor.randomColor
        noveImageView?.layer.cornerRadius = 5
        self.addSubview(noveImageView!)
        noveTitle = UILabel()
        noveTitle?.font = UIFont.systemFont(ofSize: 10)
        noveTitle?.numberOfLines = 3
        noveTitle?.text = "开始就打了客服老师发来看什么的李开复克里斯多夫了呢"
        self.addSubview(noveTitle!)
        noveAuthor = UILabel()
        noveAuthor?.text = "智深数据"
        noveAuthor?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(noveAuthor!)
        noveCategoty = UILabel()
        noveCategoty?.text = "智深数据"
        noveCategoty?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(noveCategoty!)
        noveImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.height.equalTo(150)
        })
        noveTitle?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo((noveImageView?.snp.bottom)!).offset(18)
        })
        noveAuthor?.snp.makeConstraints({ (make) in
            make.top.equalTo((noveTitle?.snp.bottom)!).offset(13)
            make.left.equalTo(self)
            //make.width.height.equalTo(30)
        })
        noveCategoty?.snp.makeConstraints({ (make) in
            make.centerY.height.equalTo(noveAuthor!)
            make.right.equalTo(self).offset(-13)
        })
        self.contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
        }
    }
}
