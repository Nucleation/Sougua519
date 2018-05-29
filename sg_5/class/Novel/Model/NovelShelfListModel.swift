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
    var novel: NovelShelfListModel?
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

class testA {
    var data = """
[{"a":"a1","b":{"a":"b1"}}]
"""
    func test()  {
        
        let json = JSON.parse(data).arrayValue
        
        let c = json.map { json -> A in
            let a  = A.deserialize(from: json.description)
            
//            a?.b = B.deserialize(from: json["b"].description)
            return a!
        }
        
 
        print(c[0].a)
         print(c[0].b?.a)
        
        
    }
    
    
    class B: HandyJSON {
        var a = ""
        public required init() {}
    }
    class A: HandyJSON {
        var a = ""
        var b:B? = nil
        public required init() {}
    }
}




