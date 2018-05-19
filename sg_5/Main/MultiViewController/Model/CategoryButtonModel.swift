//
//  CategoryButtonModel.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/10.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import HandyJSON

class CategoryButton: HandyJSON {
    var imageurl: String = ""
    var title:String = ""
    var index: Int = 0
    public required init() {}
}
class HomePageNews: HandyJSON {
    var title: String = ""
    var type: String = ""
    var source:String = ""
    var comment: Int = 0
    var newsurl: String = ""
    var imageurl:String = ""
    var imageurls:Array = [String]()
    var videourl = ""
    var cellHeight:CGFloat = 200
    public required init() {}
    
}
