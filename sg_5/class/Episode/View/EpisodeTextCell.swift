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
}
class EpisodeTextCell: UITableViewCell {
    @IBOutlet weak var sourceLab: UILabel!
    @IBOutlet weak var createTimeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dowmCountLab: UILabel!
    @IBOutlet weak var upCountLab: UILabel!
    @IBOutlet weak var commentCountLab: UILabel!
    @IBOutlet weak var allBtn: UIButton!
    var delegate: EpisodeTextCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.height = 0
        // Initialization code
    }
    func setCellByModel(model: EpisodeModel){
        sourceLab.text = model.source
         createTimeLab.text = model.createTime.subString(start: 5, length: 5)
        contentLab.text = model.content
        dowmCountLab.text = String(model.down)
        upCountLab.text = String(model.up)
        commentCountLab.text = String(model.commentNum)
        let textHeight = model.content.getTextHeigh(font: UIFont.systemFont(ofSize: 16), width: screenWidth-24)
        if textHeight < 50 {
            self.height = textHeight + 300
            self.allBtn.isHidden = true
        }else{
            self.height = 350
            self.allBtn.isHidden = false
        }
    }
    

    @IBAction func allClick(_ sender: Any) {
        if self.delegate != nil {
            delegate?.allBtnClick(sender: self)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
