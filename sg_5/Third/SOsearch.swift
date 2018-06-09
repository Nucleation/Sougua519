//
//  SOsearch.swift
//  TFHpple-swift
//
//  Created by zhishen－mac on 2018/3/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

let sharderSOsearch = SOsearch()
class SOsearch: NSObject {
    override init() {
        super .init()
    }
    var dataArr:[Content] = []
    func getData(keyWord:String) -> Array<Content> {
        let utfStr = "https://m.so.com/index.php?q=\(keyWord)&pn=1&psid=ae25a783ea0b059863b0124e30f30e0b&src=srp_paging&fr=none"
        //let data = utfStr.data(using: String.Encoding.utf8)
        let url = NSURL(string: utfStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!)
        print(url as Any)
        let htmlData = NSData(contentsOf: url! as URL)
        let doc:TFHpple = TFHpple(htmlData: htmlData! as Data, encoding: "utf-8")
        let xpath = "//*[@id=\"main\"]/div[@class=\"r-results\"]"
        let elements : NSArray = doc.search(withXPathQuery: "\(xpath)/div[@class=\" g-card res-list og \"]|\(xpath)/div[@class=\"g-card res-list sumext-tpl-image mso\"]|\(xpath)/div[@class=\"g-card res-list sumext-tpl-baike mso\"]")! as NSArray
        for obj in elements {
            let content = Content()
            if (obj as! TFHppleElement).attributes["class"] != nil{
                let ele = obj as! TFHppleElement
                let elements_t : NSArray = ele.search(withXPathQuery: "//h3[@class=\"res-title\"]")! as NSArray
                for obj_t in elements_t {
                    content.rtitle = ((obj_t as! TFHppleElement).content as String)
                   }
                let elements_c : NSArray = ele.search(withXPathQuery: "//div[@class=\"summary\"]|//*[@class=\"g-main summary\"]|//*[@class=\"g-f-ellipsis\"]|//*[@class=\"res-title\"]")! as NSArray
                for obj_c in elements_c {
                    content.rcon = ((obj_c as! TFHppleElement).content as String)
                }
                let elements_u : NSArray = ele.search(withXPathQuery: "//a")! as NSArray
                for obj_u  in elements_u {
                    content.rurl = ((obj_u as! TFHppleElement).attributes["href"] as?String) ?? ""
                }
                let elements_img : NSArray = ele.search(withXPathQuery: "//a/div/div/div/img")! as NSArray
                for obj_img  in elements_img {
                    content.rimg = ((obj_img as! TFHppleElement).attributes["data-delay-src"] as?String) ?? ""
                    content.rimg = "http:\(content.rimg)"
                }
            }
            if content.rcon != ""&&content.rtitle != ""&&content.rurl != ""{
                dataArr+=[content]
            }
        }
        return dataArr
    }
}
class Content : NSObject{
    var rtitle:String = ""
    var rurl:String = ""
    var rcon:String = ""
    var rimg:String = ""
}
