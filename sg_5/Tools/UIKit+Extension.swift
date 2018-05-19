//
//  UIKit+Extension.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol NibLoadable {}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}
protocol RegisterCellFromNib {}

extension RegisterCellFromNib {    
    static var identifier: String { return "\(self)" }
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}
extension UITableView {
    /// 注册 cell 的方法
    func ym_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellReuseIdentifier: T.identifier) }
        else { register(cell, forCellReuseIdentifier: T.identifier) }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func ym_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    // MARK:- HexString以#、0X开头
    class func colorWithHexColorString(_ color: String, alpha: CGFloat) -> UIColor {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        var cString = color.trimmingCharacters(in: whitespace).uppercased()
        let len = cString.characters.count
        if len < 6 {
            return UIColor.clear
        }
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            let start = cString.index(cString.startIndex, offsetBy: 1)
            cString = cString.substring(from: start)
        }
        if cString.characters.count != 6 {
            return UIColor.clear
        }
        var range: NSRange = NSMakeRange(0, 2)
        let myNSString = cString as NSString
        let rString = myNSString.substring(with: range)
        range.location = 2
        let gString = myNSString.substring(with: range)
        range.location = 4
        let bString = myNSString.substring(with: range)
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)    
    }
    
    class func colorWithHexColorString(_ color: String) -> UIColor {
        
        return colorWithHexColorString(color, alpha: 1.0)
        
    }
}
extension UIView {
    /// x
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
}
extension String {
    func mybase64() -> String {
        //base64编码
        let a = self
        let b = a.data(using: String.Encoding.utf8)
        let c = b!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return c
    }
    
    func myfanbase64() -> String {
        let a = self
        let b = NSData(base64Encoded: a, options: .init(rawValue: 0))! as NSData
        let c = NSString(data: b as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return c
    }
    
    func jiemi() -> JSON {
        let i = self.myfanbase64()
        let j = i.aesDecrypt
        let k = j.myfanbase64()
        var m:JSON!
        if let l = k.data(using: String.Encoding.utf8) {
            m = JSON(data:l)
        }
        
        return m
    }
    
    func jiami() -> String {
        
        let d = self.mybase64()
        let f = d.aesEncrypt
        let g = f.mybase64()
        return g
    }
}
extension Dictionary{
    func toParameterDic() -> Dictionary {
        var dicC = self as! Dictionary<String, Any>
        let sign = ParameterEncode().query(dicC)
        dicC.updateValue(sign.values.first!, forKey: sign.keys.first!)
        let parameter = JSON(dicC).description
        let parameter1 = parameter.replacingOccurrences(of: " ", with: "")
        let parameter2 = parameter1.replacingOccurrences(of: "\n", with: "")
        return ["data":parameter2.aesEncrypt] as! Dictionary<Key, Value>
    }
}
extension UIImageView{

    func AddTapFullScreenScan(){
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showImage(sender:)))
        self.addGestureRecognizer(tap)
    }
    @objc func showImage(sender: UIImageView){
        let window = UIApplication.shared.keyWindow
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0
        let imageView = UIImageView(frame: self.frame)
        imageView.image = image
        imageView.tag = 1
        backgroundView.addSubview(imageView)
        window?.addSubview(backgroundView)
        let hide = UITapGestureRecognizer(target: self, action: #selector(hideImage(sender:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(hide)
        UIView.animate(withDuration: 0.3, animations: {
            let vsize = UIScreen.main.bounds.size
            imageView.frame = CGRect(x:0.0, y: 0.0, width: vsize.width, height: vsize.height)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            backgroundView.alpha = 1
        }) { (finshed: Bool) in
        }
    }
    @objc func hideImage(sender: UITapGestureRecognizer){
        let backgroundView = sender.view as UIView?
        if let view = backgroundView {
            UIView.animate(withDuration: 0.3, animations: {
                let imageView = view.viewWithTag(1) as! UIImageView
                imageView.frame = CGRect.zero
                imageView.alpha = 0
            }) { (finshed: Bool) in
                view.alpha = 0
                view.superview?.removeFromSuperview()
                view.removeFromSuperview()
            }
        }
    }
}
