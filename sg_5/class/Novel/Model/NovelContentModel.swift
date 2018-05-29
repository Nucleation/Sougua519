//
//  NovelContentModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/29.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class NovelContentModel: HandyJSON {
    var sectionName: String = ""
    var content: String = ""
    var page: NovelContentPageModel?
    public required init() {}
}
class NovelContentPageModel: HandyJSON {
    var pageNo: String = ""
    var pageSize: String = ""
    var count: String = ""
    var totalPage: String = ""
    var limit: String = ""
    var index: String = ""
    var keyWord: String = ""
    public required init() {}
}
