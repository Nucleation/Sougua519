//
//  NovelShelfListModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class NovelShelfBaseModel: HandyJSON {
    var userId: String = ""
    var updateDate: String = ""
    var delFlag: String = ""
    var id: String = ""
    var novel: [NovelShelfListModel]?
    var sectionId: String = ""
    var createDate: String = ""
    public required init() {}
}
class NovelShelfListModel: HandyJSON {
    var del: String = ""
    var id: String = ""
    var fictionImg: String = ""
    var fictionAuthor: String = ""
    var fictionIsEnd: String = ""
    var fictionWordCount: String = ""
    var fictionName: String = ""
    var fictionBrief: String = ""
    var createTime: String = ""
    var categoryName: String = ""
    public required init() {}
}
