//
//  EpisodeInfoHeadView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class EpisodeInfoHeadView: UIView {
    var model:EpisodeModel?
    var userIcon: UIView?
    var sourceLab: UILabel?
    var timeLab: UILabel?
    var focusBtn: UIButton?
    var contentLab: UILabel?
    var contentImageView: UIImageView?
    var upBtn: UIButton?
    var shareBtn: UIButton?
    var type: Int = 0
    var totolComment: UILabel?
    var totolUp: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createUI()
        setValue()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
       
        let userIcon = UIImageView()
        userIcon.backgroundColor = UIColor.brown
        userIcon.layer.cornerRadius = 25
        self.addSubview(userIcon)
        self.userIcon = userIcon
        let sourceLab = UILabel()
        sourceLab.numberOfLines = 1
        sourceLab.text = "source"
        sourceLab.textColor = UIColor.colorWithHexColorString("333333")
        sourceLab.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(sourceLab)
        self.sourceLab = sourceLab
        let timeLab = UILabel()
        timeLab.text = "3-16"
        timeLab.numberOfLines = 1
        timeLab.textColor = UIColor.colorWithHexColorString("999999")
        timeLab.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(timeLab)
        self.timeLab = timeLab
        let focusBtn = UIButton(type: .custom)
        focusBtn.backgroundColor = UIColor.colorWithHexColorString("f85959")
        focusBtn.setTitle("关注", for: .normal)
        focusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        focusBtn.setTitleColor(.white, for: .normal)
        self.addSubview(focusBtn)
        self.focusBtn = focusBtn
        let contentLab = UILabel()
        contentLab.numberOfLines = 0
        contentLab.text = "rftgyhujikkyghijklfvghuijnmkfyghuijk"
        contentLab.textColor = UIColor.colorWithHexColorString("333333")
        contentLab.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(contentLab)
        self.contentLab = contentLab
        let contentImageView = UIImageView()
        self.addSubview(contentImageView)
        self.contentImageView = contentImageView
        let upBtn = UIButton(type: .custom)
        upBtn.setImage(UIImage(named: "dianzan"), for: .normal)
        upBtn.setTitle("3", for: .normal)
        upBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        upBtn.layer.cornerRadius = 18
        upBtn.layer.borderWidth = 1
        upBtn.layer.borderColor = UIColor.colorWithHexColorString("999999").cgColor
        upBtn.setTitleColor(.black, for: .normal)
        self.addSubview(upBtn)
        self.upBtn = upBtn
        let shareBtn = UIButton(type: .custom)
        shareBtn.setTitle("分享", for: .normal)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        shareBtn.setImage(UIImage(named: "fenxiang"), for: .normal)
        shareBtn.layer.cornerRadius = 18
        shareBtn.layer.borderWidth = 1
        shareBtn.layer.borderColor = UIColor.colorWithHexColorString("999999").cgColor
        shareBtn.setTitleColor(.black, for: .normal)
        self.addSubview(shareBtn)
        self.shareBtn = shareBtn
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorWithHexColorString("ebebeb")
        self.addSubview(lineView)
        let sectionView = UIView()
        let totolComment = UILabel()
        totolComment.text = "评论 0"
        totolComment.font = UIFont.systemFont(ofSize: 14)
        totolComment.textColor = UIColor.colorWithHexColorString("666666")
        sectionView.addSubview(totolComment)
        let totolUp = UILabel()
        totolUp.text = "0 赞"
        totolUp.font = UIFont.systemFont(ofSize: 14)
        totolUp.textColor = UIColor.colorWithHexColorString("666666")
        sectionView.addSubview(totolUp)
        self.addSubview(sectionView)
        self.totolComment = totolComment
        self.totolUp = totolUp
        self.userIcon?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(27)
            make.width.height.equalTo(50)
        })
        self.sourceLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.userIcon!.snp.right).offset(14)
            make.top.equalTo(self).offset(32)
            make.height.equalTo(20)
        })
        self.timeLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.sourceLab!)
            make.top.equalTo(self.sourceLab!.snp.bottom).offset(6)
            make.height.equalTo(20)
        })
        self.focusBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp.right).offset(-17)
            make.top.equalTo(self).offset(30)
            make.height.equalTo(30)
            make.width.equalTo(60)
        })
        self.contentLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self.userIcon!.snp.bottom).offset(25)
            make.right.equalTo(self).offset(-12)
        })
        self.contentImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(12)
            make.width.equalTo(135)
            make.height.equalTo(125)
            make.top.equalTo(self.contentLab!.snp.bottom).offset(20)
        })
        self.upBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentImageView!.snp.bottom).offset(25)
            make.right.equalTo(self.snp.centerX).offset(-25)
            make.width.equalTo(110)
            make.height.equalTo(35)
        })
        self.shareBtn?.snp.makeConstraints({ (make) in
            make.centerY.height.width.equalTo(self.upBtn!)
            make.left.equalTo(self.snp.centerX).offset(25)
            
        })
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.shareBtn!.snp.bottom).offset(25)
            make.height.equalTo(10)
        }
        sectionView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(40)
            make.bottom.equalTo(self).offset(-10)
        }
        self.totolComment?.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        self.totolUp?.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
    func setValue() {
        if model != nil {
            if model?.mark == "3"{
                self.contentLab?.text = model?.title
            }else{
                if model?.mark == "2"{
                    self.contentImageView?.kf.setImage(with: URL(string: model?.contentImg ?? ""))
                }
                self.contentLab?.text = model?.content
            }
            self.sourceLab?.text = model?.source
            self.timeLab?.text = model?.createTime.subString(start: 5, length: 5)
            self.upBtn?.setTitle(String(model!.up), for: .normal)
        }
        if model?.mark == "1" {
            self.contentImageView?.snp.updateConstraints({ (make) in
                make.height.equalTo(0)
            })
        }else if model?.mark == "2"{
            self.contentImageView?.snp.updateConstraints({ (make) in
                make.height.equalTo(125)
            })
        }else{
            self.contentImageView?.snp.updateConstraints({ (make) in
                make.height.equalTo(0)
            })
        }
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
}
