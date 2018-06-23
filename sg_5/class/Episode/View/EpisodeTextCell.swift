//
//  EpisodeTextCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol EpisodeTextCellDelegate {
    func allBtnClick(sender: EpisodeTextCell)
    func textCellup(sender: EpisodeTextCell)
    func textCelldown(sender: EpisodeTextCell)
    func textCellcomment(sender: EpisodeTextCell)
    func textCellShare(sender: EpisodeTextCell)
}
class EpisodeTextCell: UITableViewCell {
    @IBOutlet weak var sourceLab: UILabel!
    @IBOutlet weak var createTimeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dowmCountLab: UILabel!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var upCountLab: UILabel!
    @IBOutlet weak var commentCountLab: UILabel!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    var model = EpisodeModel() {
        didSet {
            if model.isUp {
                self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
            }else{
                self.upBtn.setImage(UIImage(named: "dianzan"), for: .normal)
            }
            if model.isDown {
                self.downBtn.setImage(UIImage(named: "dianzan4"), for: .normal)
            }else{
                self.downBtn.setImage(UIImage(named: "dianzan1"), for: .normal)
            }
            self.contentLab.numberOfLines = 4
            sourceLab.text = model.source
            createTimeLab.text = model.createTime.subString(start: 5, length: 5)
            contentLab.text = model.content
            dowmCountLab.text = String(model.down)
            upCountLab.text = String(model.up )
            commentCountLab.text = String(model.commentNum)
            let textHeight = model.content.getTextHeigh(font: UIFont.systemFont(ofSize: 16), width: screenWidth-24)
            if !model.isShowAll{
                if textHeight < 50 {
                    self.allBtn.isHidden = true
                }else{
                    self.allBtn.isHidden = false
                }
            }else{
                self.allBtn.isHidden = true
                self.contentLab.numberOfLines = 0
                self.allBtn.isHidden = true
            }
            if model.authorPortrait != "" {
                userIcon.kf.setImage(with: URL(string: model.authorPortrait))
            }else{
                userIcon.image = UIImage(named: "userIMG")
            }
        }
    }
    
    var delegate: EpisodeTextCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.height = 0
        
        // Initialization code
    }
    func setCellByModel(model: EpisodeModel){
        
    }
    

    @IBAction func allClick(_ sender: Any) {
        if self.delegate != nil {
            delegate?.allBtnClick(sender: self)
        }
    }
    
    @IBAction func commentBtnClick(_ sender: Any) {
        if self.delegate != nil {
            delegate?.textCellcomment(sender: self)
        }
    }
    @IBAction func downBtnClick(_ sender: Any) {
        if self.delegate != nil {
            delegate?.textCelldown(sender: self)
            model.down += 1
            dowmCountLab.text = String(model.down)
            model.isDown = true
            self.downBtn.setImage(UIImage(named: "dianzan4"), for: .normal)
            self.downBtn.isEnabled = false
        }
    }
    @IBAction func upBtnClick(_ sender: Any) {
        if !model.isUp {
            if self.delegate != nil{
                model.isUp = true
                model.up += 1
                self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
                self.upBtn.isEnabled = false
                self.upCountLab.text = String(model.up)
                delegate?.textCellup(sender: self)
            }
        }else{
            self.makeToast("已赞")
        }
    }
    @IBAction func shareBtnClick(_ sender: Any) {
        if self.delegate != nil{
            delegate?.textCellShare(sender: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
