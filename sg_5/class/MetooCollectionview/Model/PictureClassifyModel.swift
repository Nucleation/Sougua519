//
//  PictureClassifyModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import HandyJSON

class PictureClassifyModel: HandyJSON {
    var source: String = ""
    var downloadUrl: String = ""
    var id: String = ""
    var fileUrl: String = ""
    var type: String = ""
    var name: String = ""
    var createTime: String = ""
    var countPraise: String = ""
    public required init() {}
}
