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
    func savekeyChain(dic: Dictionary<String, String>){
        let keyChain = KeychainSwift()
        keyChain.set(dic["mobile"]!, forKey: "mobile")
        keyChain.set(dic["id"]!, forKey: "id")
        keyChain.set(dic["token"]!, forKey: "token")
    }
    func getKeyChain() -> Dictionary<String, String>{
        let keyChain = KeychainSwift()
        return ["mobile":"\(keyChain.get("mobile") ?? "")","id":"\(keyChain.get("id") ?? "")","token":"\(keyChain.get("token") ?? "")"]
    }
}
