//
//  EpisodeCommentTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class EpisodeCommentTableViewCell: UITableViewCell {
    var model = NovelCommentModel(){
        didSet {
            userNameLab.text = model.fromId
            commentLab.text = model.content
            timeLab.text = model.createDate
            upBtn.setTitle(model.upCount, for: .normal)
        }
    }
    @IBOutlet weak var userIconImg: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var upBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
