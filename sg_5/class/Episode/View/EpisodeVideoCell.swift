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
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var upCountLab: UILabel!
    @IBOutlet weak var commentCountLab: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    var model = EpisodeModel() {
        didSet {
            if model.isUp {
                self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
            }else{
                self.upBtn.setImage(UIImage(named: "dianzan"), for: .normal)
            }
            sourceLab.text = model.source
            createTimeLab.text = model.createTime.subString(start: 5, length: 5)
            contentLab.text = model.title
            dowmCountLab.text = String(model.down)
            upCountLab.text = String(model.up)
            commentCountLab.text = String(model.commentNum)
            contentImageView.kf.setImage(with: URL(string: model.pic))
        }
    }
    var delegate:EpisodeVideoCellDelegate?
    
     var cellHeight:CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        if !model.isUp {
            if self.delegate != nil{
                model.isUp = true
                model.up += 1
                self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
                self.upCountLab.text = String(model.up)
                delegate?.videoCellup(sender: self)
            }
        }else{
            self.makeToast("已赞")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
