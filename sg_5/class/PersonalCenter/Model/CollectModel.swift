//
//  CollectModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/12.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class CollectModel: HandyJSON {
//    "id": "1",
//    "createDate": "2018-05-17  16:36:53",
//    "updateDate": "2018-05-17  16:36:50",
//    "createBy": "1",
//    "updateBy": "1",
//    "userId": "1",
//    "contentId": "1",
//    "type": "1",
//    "title": "1",
//    "url": "1",
//    "source": "1",
//    "commentCount": 0，
//    "mark":" "
    var id: String = ""
    var createDate: String = ""
    var updateDate: String = ""
    var createBy: String = ""
    var updateBy: String = ""
    var userId: String = ""
    var contentId: String = ""
    var type: String = ""
    var title: String = ""
    var url: String = ""
    var source: String = ""
    var commentCount: Int = 0
    var mark: String = ""//标记：1 纯文本 2带图的 3视频
    public required init() {}
}
