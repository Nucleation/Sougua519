//
//  NoveCategoryListModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import HandyJSON

class NoveCategoryListModel: HandyJSON {
//    "del" : "0",
//    "id" : "0012c3041ec311e88a9f801844e634d8",
//    "fictionImg" : "https:\/\/qidian.qpic.cn\/qdbimg\/349573\/c_4698846604107701\/180\r",
//    "fictionAuthor" : "果而 ",
//    "fictionIsEnd" : "已完结",
//    "fictionWordCount" : "41.37万字",
//    "fictionName" : "沈少的合约妻",
//    "fictionBrief" : "r        ",
//    "createTime" : "2018-03-03 17:12:30.0",
//    "categoryName" : "现代言情"
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
