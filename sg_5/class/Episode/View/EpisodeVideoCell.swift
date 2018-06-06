//
//  EpisodeVideoCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol EpisodeVideoCellDelegate {
    func videoCellup(sender: EpisodeVideoCell)
    func videoCelldown(sender: EpisodeVideoCell)
    func videoCellcomment(sender: EpisodeVideoCell)
}
class EpisodeVideoCell: UITableViewCell {
    @IBOutlet weak var sourceLab: UILabel!
    @IBOutlet weak var createTimeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dowmCountLab: UILabel!
    @IBOutlet weak var upCountLab: UILabel!
    @IBOutlet weak var commentCountLab: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    var delegate:EpisodeVideoCellDelegate?
    
     var cellHeight:CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellByModel(model: EpisodeModel){
        sourceLab.text = model.source
         createTimeLab.text = model.createTime.subString(start: 5, length: 5)
        contentLab.text = model.title
        dowmCountLab.text = String(model.down)
        upCountLab.text = String(model.up)
        commentCountLab.text = String(model.commentNum)
        contentImageView.kf.setImage(with: URL(string: model.pic))
        self.height = (model.title.getTextHeigh(font: UIFont.systemFont(ofSize: 16), width: screenWidth-24)) + 300
    }
    
    @IBAction func commentBtnClick(_ sender: Any) {
        if self.delegate != nil{
            delegate?.videoCellcomment(sender: self)
        }
    }
    @IBAction func downBtnClick(_ sender: Any) {
        if self.delegate != nil{
            delegate?.videoCelldown(sender: self)
        }
    }
    @IBAction func upBtnClick(_ sender: Any) {
        if self.delegate != nil{
            delegate?.videoCellup(sender: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
