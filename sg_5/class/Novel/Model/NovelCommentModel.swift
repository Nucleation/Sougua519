//
//  NovelCommentModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/22.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON

class NovelCommentModel: HandyJSON {
    var fromId: String = ""
    var typeId: String = ""
    var content: String = ""
    var id: String = ""
    var createDate: String = ""
    var type: String = ""
    var upCount: Int = 0
    var fromHeadUrl: String = ""
    var fromMobile: String = ""
    var createBy: String = ""
    var isUp:Bool = false
    
    public required init() {}
}
