
/*
    #import "CocoaSecurity.h"
 */

let aes_key = "NzoxMTowMCAgICAg".data(using: String.Encoding.utf8)
let aes_iv = "TW9uIE9jdCAzMCAx".data(using: String.Encoding.utf8)

let aes_key1 = "zj6esdzzw3sgdgjrr79b7l2w1a6us2qf".data(using: String.Encoding.utf8)
let aes_iv1 = "i02ax8w9x9dee759".data(using: String.Encoding.utf8)
let app_name = "daikuanchaoshi"



extension String{
    var aesEncrypt:String {
        get{
            
            return CocoaSecurity.aesEncrypt(with: self.data(using: String.Encoding.utf8), key: aes_key, iv:aes_iv).base64
        }
    }
    
    var aesDecrypt:String{
        get{
            if let a  = CocoaSecurity.aesDecrypt(withBase64: self, key: aes_key, iv:aes_iv).utf8String {
                return a.replacingOccurrences(of: "\0", with: "")
            }
            return ""
        }
    }
    
    var aesEncrypt1:String {
        get{
            return CocoaSecurity.aesEncrypt(with: self.data(using: String.Encoding.utf8), key: aes_key1, iv:aes_iv1).base64
        }
    }
    
    var aesDecrypt1:String{
        get{
            if let a  = CocoaSecurity.aesDecrypt(withBase64: self, key: aes_key1, iv:aes_iv1).utf8String {
                return a.replacingOccurrences(of: "\0", with: "")
            }
            return ""
        }
    }
    
    
   
}
/*

 调用
 
    let a  = "123".aesEncrypt
    let b = a.aesDecrypt
    print(a)
    print(b)
*/
