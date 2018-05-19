//
//  Foundation+Extension.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/10.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
class ParameterEncode {
    func query(_ parameters: [String: Any]) -> [String:Any] {
        var components: [(String, Any)] = []
        var result = [String : Any ]()
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            print(value)
            components += queryComponents(fromKey: key, value: value)
        }
        print(components)
        print((components.map { "\($0)=\($1)" }.joined(separator: "&")))
        result["sign"] = (components.map { "\($0)=\($1)" }.joined(separator: "&")).MD5().uppercased() 
        return result
    }
    func queryComponents(fromKey key: String, value: Any) -> [(String, Any)] {
        var components: [(String, Any)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        }else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    //MARK: -- URL不对中文转码
    public func escape(_ string: String) -> String {
//        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
//        let subDelimitersToEncode = "!$&'()*+,;="
//
//        var allowedCharacterSet = CharacterSet.urlQueryAllowed
//        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//
//        var escaped = ""
//
//        //==========================================================================================================
//        //
//        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
//        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
//        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
//        //  info, please refer to:
//        //
//        //      - https://github.com/Alamofire/Alamofire/issues/206
//        //
//        //==========================================================================================================
//
//        if #available(iOS 8.3, *) {
//            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
//        } else {
//            let batchSize = 50
//            var index = string.startIndex
//
//            while index != string.endIndex {
//                let startIndex = index
//                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
//                let range = startIndex..<endIndex
//
//                let substring = string[range]
//
//                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
//
//                index = endIndex
//            }
//        }
        
        return string
    }
}
extension Int
{
    func hexedString() -> String
    {
        return NSString(format:"%02x", self) as String
    }
}

extension NSData
{
    func hexedString() -> String
    {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start:unsafePointer, count: length)
        {
            string += Int(i).hexedString()
        }
        return string
    }
    func MD5() -> NSData
    {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
}

extension String
{
    func MD5() -> String
    {
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
        return data.MD5().hexedString()
    }
}

//extension NSNumber {
//    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
//}
