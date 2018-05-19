//
//  SingleTestTableViewCell.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/11.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class SingleTestTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsFrom: UILabel!
    @IBOutlet weak var reviewLab: UILabel!
    var aNews = HomePageNews(){
        didSet {
            titleLabel.text = aNews.title
            newsFrom.text = aNews.source
            reviewLab.text = "评论:\(aNews.comment)"
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
