//
//  NoticeModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class NoticeModel: HandyJSON {
    var id:String = ""
    var title:String = ""
    var content:String = ""
    var okButton:String = ""
    var cancelButton:String = ""
    var url:String = ""
    var type:Int = 0
    var createTime:String = ""
    public required init() {}
}
