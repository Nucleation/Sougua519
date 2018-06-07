//
//  HomePageNewsModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/23.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON

class HomePageNewsModel: HandyJSON {
//    "id" : "007d1ed85cdd11e8ae9d00e04c12a789",
//    "originalName" : "",
//    "createtime" : "2018-05-21 17:54:50.0",
//    "discussCount" : "",
//    "originalPortrait" : "",
//    "imageUrl" : "http:\/\/i.gtimg.cn\/qqlive\/images\/20150608\/pic_h.png",
//    "title" : "青海省各地开展第二十八次“全国助残日”宣传活动",
//    "newsContent" : "blob:http:\/\/v.qq.com\/ac653868-0e28-4809-9923-3f72b4024457",
//    "figureTime" : "00:01:30",
//    "type" : "1",
//    "source" : "腾讯视频",
//    "directType" : "",
//    "originalPath" : "",
//    "del" : "0",
//    "nextType" : ""
    var id: String = ""
    var originalName: String = ""
    var createtime:String = ""
    var discussCount: String = ""
    var imageUrl: String = ""
    var title:String = ""
    var newsContent:String = ""
    var figureTime:String = ""
    var type:String = ""
    var source: String = ""
    var directType: String = ""
    var originalPath:String = ""
    var del:String = ""
    var nextType:String = ""
    var modelType:String = ""
    var originalCreate_date:String = ""
    var originalPortrait:String = ""
    var up:String = ""
    public required init() {}
}
