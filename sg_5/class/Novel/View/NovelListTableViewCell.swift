//
//  NovelListTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/25.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelListTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookAuthorLab: UILabel!
    @IBOutlet weak var bookTitleLab: UILabel!
    @IBOutlet weak var bookContentLab: UILabel!
    @IBOutlet weak var fictionIsEndLab: UILabel!
    @IBOutlet weak var categoryLab: UILabel!
    @IBOutlet weak var fictionWordCountLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellwithModel(model: NoveCategoryListModel){
        bookImage.kf.setImage(with: URL(string: model.fictionImg))
        bookAuthorLab.text = model.fictionAuthor
        bookTitleLab.text = model.fictionName
        bookContentLab.text = model.fictionBrief.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        fictionIsEndLab.text = model.fictionIsEnd
        categoryLab.text = model.categoryName
        fictionWordCountLab.text = model.fictionWordCount
    }
    
}
