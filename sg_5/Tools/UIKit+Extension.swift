//
//  UIKit+Extension.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    class var colorAccent: UIColor{
        get {
            return UIColor.colorWithHexColorString("017CFA")
        }
    }
    class var colortext1: UIColor{
        get {
            return UIColor.colorWithHexColorString("333333")
        }
    }
    class var colortext2: UIColor{
        get {
            return UIColor.colorWithHexColorString("666666")
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
    func getTextHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText: NSString = self as NSString
        let size = CGSize(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context:nil).size
        return stringSize.height
    }
}
extension Dictionary{
    func toParameterDic() -> Dictionary {
        var dicC = self as! Dictionary<String, Any>
        let sign = ParameterEncode().query(dicC)
        dicC.updateValue(sign.values.first!, forKey: sign.keys.first!)
        let parameter = JSON(dicC).description
        //let parameter1 = parameter.replacingOccurrences(of: " ", with: "")
        //let parameter2 = parameter1.replacingOccurrences(of: "\n", with: "")
        return ["data":parameter.aesEncrypt] as! Dictionary<Key, Value>
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
enum EmptyType {
    case emptyData
    case networkError
}

protocol EmptyDataSetProtocol { }

extension EmptyDataSetProtocol where Self : UIViewController {
    
    func addEmptyView(type: EmptyType? = .emptyData, iconName: String, tipTitle: String, action: Selector? = nil) {
        
        let emptyView = UIView(frame: view.bounds)
        emptyView.backgroundColor = UIColor.white
        emptyView.tag = 1024
        view.addSubview(emptyView)
        
        let icomViewW: CGFloat = 100
        let imageView = UIImageView(image: UIImage(named: iconName))
        imageView.frame.size = imageView.image?.size ?? CGSize(width: icomViewW, height: icomViewW)
        imageView.contentMode = .center
        imageView.center = CGPoint(x: emptyView.center.x, y: emptyView.center.y - 100)
        emptyView.addSubview(imageView)
        
        let tipLabel = UILabel()
        let margin: CGFloat = 20
        tipLabel.numberOfLines = 0
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textColor = UIColor.lightGray
        
        if tipTitle.contains("\n") {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5 // 设置行间距
            style.alignment = .center // 文字居中
            //let tipString = NSAttributedString(string: tipTitle, attributes: [NSParagraphStyleAttributeName: style])
            let tipString = NSAttributedString(string: tipTitle, attributes: [NSAttributedStringKey.paragraphStyle: style])
            tipLabel.attributedText = tipString
        } else {
            tipLabel.text = tipTitle
        }
        tipLabel.adjustsFontSizeToFitWidth = true
        tipLabel.textAlignment = .center
        tipLabel.sizeToFit()
        tipLabel.frame = CGRect(x: margin, y: imageView.frame.maxY + margin, width: UIScreen.main.bounds.width - margin*2, height: tipLabel.bounds.height)
        emptyView.addSubview(tipLabel)
        
        // 网络请求失败
        if type == .networkError {
            
            let reloadButton = UIButton(type: .system)
            reloadButton.frame.size = CGSize(width: 100, height: 36)
            reloadButton.center = CGPoint(x: emptyView.center.x, y: tipLabel.frame.maxY + margin*2)
            reloadButton.backgroundColor = UIColor(red: 255/255.0, green: 42/255.0, blue: 102/255.0, alpha: 1.0)
            reloadButton.layer.cornerRadius = 18
            reloadButton.layer.masksToBounds = true
            reloadButton.setTitle("重新加载", for: .normal)
            reloadButton.setTitleColor(UIColor.white, for: .normal)
            reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            reloadButton.addTarget(self, action: action!, for: .touchUpInside)
            emptyView.addSubview(reloadButton)
        }
        
    }
    
    func hideEmptyView() {
        view.subviews.filter({ $0.tag == 1024 }).first?.removeFromSuperview()
    }
}
@IBDesignable
class UILabelPadding : UILabel {
    
    private var padding = UIEdgeInsets.zero
    
    @IBInspectable
    var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
}
