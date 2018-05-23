//
//  NovelCommentTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/22.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelCommentTableViewCell: UITableViewCell {
    
    var comment = NovelCommentModel(){
        didSet {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
