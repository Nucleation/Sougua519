//
//  MetooCollectionViewCell.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/5/8.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MetooCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    var desLab: UILabel?
    var circleImage: UIImageView?
    var fromLab: UILabel?
    var collcetBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        //self.backgroundColor = UIColor.randomColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCellWithModel(model: PictureClassifyModel){
        self.imageView?.kf.setImage(with: URL(string:"\(model.downloadUrl)"))
        self.fromLab?.text = model.source
        self.desLab?.text = model.name
        self.collcetBtn?.setTitle(model.countPraise, for: .normal)
    }
    func setUI(){
        imageView = UIImageView(image: UIImage(named: "333"))
        imageView?.layer.masksToBounds = true
        //imageView?.AddTapFullScreenScan()
        //imageView?.backgroundColor = UIColor.randomColor
        imageView?.layer.cornerRadius = 5
        self.addSubview(imageView!)
        desLab = UILabel()
        desLab?.numberOfLines = 2
        desLab?.text = "开始就打了客服老师发来看什么的李开复克里斯多夫了呢"
        self.addSubview(desLab!)
        circleImage = UIImageView()
        circleImage?.backgroundColor = UIColor.randomColor
        circleImage?.layer.cornerRadius = 10
        self.addSubview(circleImage!)
        fromLab = UILabel()
        fromLab?.text = "智深数据"
        fromLab?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(fromLab!)
        collcetBtn = UIButton(type: .custom)
        collcetBtn?.setImage(UIImage(named: "shoucang"), for: .normal)
        collcetBtn?.setTitle("收藏", for: .normal)
        collcetBtn?.setTitleColor(.black, for: .normal)
        collcetBtn?.titleLabel?.textAlignment = .right
        self.addSubview(collcetBtn!)
        imageView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0)
        })
        desLab?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo((imageView?.snp.bottom)!).offset(18)
        })
        circleImage?.snp.makeConstraints({ (make) in
            make.top.equalTo((desLab?.snp.bottom)!).offset(13)
            make.left.equalTo(self)
            make.width.height.equalTo(0)
        })
        fromLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((desLab?.snp.bottom)!).offset(13)
            make.height.equalTo(25)
            make.left.equalTo(self).offset(7)
        })
        collcetBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self)
            make.height.equalTo(30)
            make.centerY.equalTo(fromLab!)
            make.width.equalTo(100)
        })
        self.contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
        }
    }
    func setImageViewHeight(indexPath: IndexPath) {
        if indexPath.row == 0 {
            imageView?.snp.remakeConstraints({(make) in
                make.top.left.right.equalTo(self)
                make.height.equalTo(105)
            })
        }else if (indexPath.row - Int(1)) % 4 < 2 {
            imageView?.snp.remakeConstraints({ (make) in
                make.top.left.right.equalTo(self)
                make.height.equalTo(155)
            })
        }else{
            imageView?.snp.remakeConstraints({ (make) in
                make.top.left.right.equalTo(self)
                make.height.equalTo(105)
            })
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
