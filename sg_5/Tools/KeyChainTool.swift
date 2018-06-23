//
//  KeyChainTool.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/22.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import KeychainSwift

struct KeyChain {
    func setKeyChain(value:String, forKey: String){
        KeychainSwift().set(value, forKey: forKey)
    }
    func savekeyChain(dic: Dictionary<String, String>){
        let keyChain = KeychainSwift()
        keyChain.set(dic["mobile"]!, forKey: "mobile")
        keyChain.set(dic["id"]!, forKey: "id")
        keyChain.set(dic["token"]!, forKey: "token")
        keyChain.set(dic["isLogin"]!, forKey: "isLogin")
        keyChain.set(dic["headUrl"]!, forKey: "headUrl")
        keyChain.set(dic["passwd"]!, forKey: "passwd")
        
    }
    func clearkeyChain(){
        let keyChain = KeychainSwift()
        keyChain.set("", forKey: "mobile")
        keyChain.set("", forKey: "id")
        keyChain.set("", forKey: "token")
        keyChain.set("0", forKey: "isLogin")
        keyChain.set("", forKey: "headUrl")
        keyChain.set("", forKey: "passwd")
        
    }
    func getKeyChain() -> Dictionary<String, String>{
        
        let keyChain = KeychainSwift()
        return ["mobile":"\(keyChain.get("mobile") ?? "")","id":"\(keyChain.get("id") ?? "")","token":"\(keyChain.get("token") ?? "")","isLogin":"\(keyChain.get("isLogin") ?? "0")","headUrl":"\(keyChain.get("headUrl") ?? "")","passwd":"\(keyChain.get("passwd") ?? "")"]
    }
}
class history: NSObject, NSCoding {
    var history:String
    
    //构造方法
    required init(history:String="") {
        self.history = history
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.history = decoder.decodeObject(forKey: "History") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(history, forKey:"History")
    }
}

