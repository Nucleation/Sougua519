//
//  NovelChapterModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/30.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class NovelChapterModel: HandyJSON {
    var id: String = ""
    var fictionId: String = ""
    var sectionName: String = ""
    var sectionUrl: String = ""
    var createTime: String = ""
    var del: String = ""
    var iindex: Int = 1
    public required init() {}
}
