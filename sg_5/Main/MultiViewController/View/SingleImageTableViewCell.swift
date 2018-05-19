//
//  SingleImageTableViewCell.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/11.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class SingleImageTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var reviewLab: UILabel!
    @IBOutlet weak var newsFrom: UILabel!
    
    var aNews = HomePageNews(){
        didSet {
            titleLabel.text = aNews.title
            image1.kf.setImage(with: URL(string: aNews.imageurl))
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
