//
//  Foundation+Extension.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/10.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit
class ParameterEncode {
    func query(_ parameters: [String: Any]) -> [String:Any] {
        var components: [(String, Any)] = []
        var result = [String : Any ]()
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        print("签名参数\(components.map { "\($0)=\($1)" }.joined(separator: "&"))")
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
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    func stringToAttribute(keyWord: String) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string:self)
        let range = (self as NSString).range(of: keyWord)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
        return attributedString
        
    }
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    func isTelNumber() -> Bool {
        let mobile = "^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|147|145)\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|73|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
}
extension Date
{
    func dateNowAsString() -> String {
        let nowDate = Date()
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "MM-dd"
        let date = formatter.string(from: nowDate)
        return date
    }
}
//extension NSNumber {
//    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
//}
