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
}
class EpisodeTextCell: UITableViewCell {
    @IBOutlet weak var sourceLab: UILabel!
    @IBOutlet weak var createTimeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dowmCountLab: UILabel!
    @IBOutlet weak var upCountLab: UILabel!
    @IBOutlet weak var commentCountLab: UILabel!
    @IBOutlet weak var allBtn: UIButton!
    var model = EpisodeModel() {
        didSet {
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
        }
    }
    @IBAction func upBtnClick(_ sender: Any) {
        if self.delegate != nil {
            delegate?.textCellup(sender: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
