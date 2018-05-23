//
//  NovelCommentTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/22.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var userIconImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    var comment = NovelCommentModel(){
        didSet {
            self.userName.text = comment.fromId
            self.commentLab.text = comment.content
            self.timeLab.text = comment.createDate
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userIconImg.layer.cornerRadius = 25
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
