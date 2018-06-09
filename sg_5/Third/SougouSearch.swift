//
//  SougouSearch.swift
//  TFHpple-swift
//
//  Created by zhishen－mac on 2018/3/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
let sharderSougou = SougouSearch()

class SougouSearch: NSObject {
    
    func getData(keyWord: String) -> Array<Content> {
        var dataArr: [Content] = []
        //手机端
        //let urlStr = "https://m.sogou.com/web/searchList.jsp?s_from=pcsearch&keyword=\(keyWord)"
        //pc端
        let urlStr = "https://www.sogou.com/web?query=\(keyWord)&_asf=www.sogou.com&_ast=1522634749&w=01019900&p=40040100&ie=utf8&from=index-nologin&s_from=index&sut=1631&sst0=1522634749530&lkt=2%2C1522634747899%2C1522634748100&sugsuv=1522031598326359&sugtime=1522634749530"
        let url = NSURL(string: urlStr.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlFragmentAllowed)!)
        let htmlData = NSData(contentsOf: url! as URL)
        //let str = String(data: htmlData! as Data, encoding: String.Encoding.utf8)
        let doc:TFHpple = TFHpple(htmlData: htmlData! as Data, encoding: "utf-8")
        let elements:NSArray = doc.search(withXPathQuery: "//*[@id=\"main\"]/div/div[@class=\"results\"]/div")! as NSArray
        for obj in elements {
            let content = Content()
            let ele = obj as! TFHppleElement
            let arrT = ele.search(withXPathQuery: "//h3")! as NSArray
            for title in arrT{
                if let ele_a:TFHppleElement = title as? TFHppleElement{
                    content.rtitle = ele_a.content
                                }
            }
            let arrU = ele.search(withXPathQuery: "//h3/a")! as NSArray
            for a_url in arrU{
                if let ele_u:TFHppleElement = a_url as? TFHppleElement{
                    content.rurl = (ele_u.attributes["href"] as?String) ?? ""
                }
            }
            let arrC = ele.search(withXPathQuery: "//*[@class=\"str_info\"]|//*[@class=\"ft\"]|//*[@class=\"str-text-info\"]/span")! as NSArray
            for titlCon in arrC{
                if let ele_c:TFHppleElement = titlCon as? TFHppleElement{
                   content.rcon = ele_c.content
                   }
               }
            let elements_img : NSArray = ele.search(withXPathQuery: "//*[@class=\"str_img size_120_90\"]/img|//*[@class=\"str_img size_120_80\"]/img|//*[@class=\"str_img size_90_90\"]/img|//*[@class=\"str_img size_120_135\"]/img")! as NSArray
            for obj_img  in elements_img {
                content.rimg = ((obj_img as! TFHppleElement).attributes["src"] as?String) ?? ""
                print(content.rimg)
                }
            if !(content.rcon == ""||content.rtitle == ""||content.rurl == ""){
                    dataArr+=[content]
               }
        }
//手机端，图片因为通过JavaScript加载，静态解析无法获取
//        let elements : NSArray = doc.search(withXPathQuery: "//*[@class=\"reswrap\"]/div[@class=\"resitem\"]")! as NSArray
//        for obj in elements {
//
//            let content = Content()
//            let ele = obj as! TFHppleElement
//            print(ele.attributes["class"] as Any)
//            let arrT = ele.search(withXPathQuery: "//a")! as NSArray
//            for title in arrT{
//                if let ele_a:TFHppleElement = title as? TFHppleElement{
//                    content.rtitle = ele_a.content
//                    content.rurl = (ele_a.attributes["href"] as?String) ?? ""
//                }
//            }
//            let arrC1 = ele.search(withXPathQuery: "//*[@class=\"abs\"]")! as NSArray
//            for titlCon in arrC1{
//                if let ele_c:TFHppleElement = titlCon as? TFHppleElement{
//                    content.rcon = ele_c.firstChild.content
//                }
//            }
//            let elements_img : NSArray = ele.search(withXPathQuery: "//*[@id=\"sogou_vr_30010097_1_img\"]")! as NSArray
//            for obj_img  in elements_img {
//                content.rimg = ((obj_img as! TFHppleElement).attributes["src"] as?String) ?? ""
//            }
//             if !(content.rcon == ""&&content.rtitle == ""&&content.rurl == ""){
//                dataArr+=[content]
//            }
//        }
       return dataArr
    }  
}
