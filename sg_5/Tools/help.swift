//
//  help.swift
//  liuliangsupermark
//
//  Created by zhishen01 on 2017/11/3.
//  Copyright © 2017年 wangzhinan. All rights reserved.
//

import UIKit
//import MBProgressHUD
//判断手机号
func isTelNumber(num:NSString)->Bool
{
    let mobile = "^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|147|145)\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((33|53|73|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true))
    {
        return true
    }
    else
    {
        return false
    }
}

func myprint(_ any:Any){
    //    print(any)
}

//纯色转图片
func imageFromColor(color: UIColor) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: KscreenW(), height: KscreenH())
    
    UIGraphicsBeginImageContext(rect.size)
    let context: CGContext = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor)
    context.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsGetCurrentContext()
    return image!
}

//navigation的颜色
func navigation() {
    
//    self.navigationController?.navigationBar.isTranslucent = false
//    self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(color: navigationColor(red: 65, green: 172, blue: 255)), for: .any, barMetrics: .default)
}






//消息
func messageAlert(_ title:String) {
    let alert = UIAlertController(title: "提示", message: title, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "确定", style: .cancel) { _ in

        alert.dismiss(animated: true, completion: nil)
    })
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    
}

func mainblue() -> UIColor{
    return UIColor(red: 65/255.0, green: 172/255.0, blue: 255/255.0, alpha: 1.0)
}

func mainGray() -> UIColor {
    return UIColor(red: 193/255.0, green: 193/255.0, blue: 193/255.0, alpha: 1.0)
}

func mycolcor(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}

func navigationColor(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
    return UIColor(red: (red + 9)/255.0, green: (green + 9)/255.0, blue: (blue + 9)/255.0, alpha: 1.0)
}


func baseColor()->UIColor{
    return UIColor(red: 243/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
}

func shoujihaojiami(text:NSString) ->String {
    
    let b = text.replacingCharacters(in: NSMakeRange(3, 4), with: "****")
    return b
}



func KscreenW() -> CGFloat {
    return UIScreen.main.bounds.size.width
}


func KscreenH() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

//button倒计时
func delay(_ sender:UIButton,_ count:Int) {
    weak var sender = sender
    guard count > -1 else {
        return
    }
    sender?.isEnabled = false
    if count == 0{
        sender?.setTitle("获取验证码", for: .normal)
        sender?.isEnabled = true
        //sender?.backgroundColor = baseColor()
        return
    }
    let time: TimeInterval = 1.0
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
       // sender?.setTitle("\(count)s后重发", for: .normal)
        sender?.titleLabel?.text = "\(count)s后重发"
        sender?.setTitle("\(count)s后重发", for: .normal)
        //sender?.backgroundColor = UIColor.lightGray
        if let sender = sender{
            delay(sender, count-1)
        }
      
    }
}

//加载hud

var view1:UIView!
func showHUD(view:UIView) {
    
    DispatchQueue.main.async {
        view1 = UIView(frame: CGRect(x: 0, y: 0, width: KscreenW(), height: KscreenH()))
        view1.backgroundColor = UIColor.clear
        
        //MBProgressHUD.showAdded(to: view1, animated: true)
        
        view.addSubview(view1)
    }
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
        hideHUD(view:view)
    }
}


//消失

func hideHUD(view:UIView) {

     DispatchQueue.main.async {
        //MBProgressHUD.hide(for: view1, animated: true)
        view1.removeFromSuperview()
    }
    
}









//显示信息hud



//上拉刷新视图
func getJiaZaiView(loadMoreEnable:Bool) -> UIView {
    let loadMoreView = UIView(frame: CGRect(x:0, y:0,width:KscreenW(), height:80))
    loadMoreView.autoresizingMask = UIViewAutoresizing.flexibleWidth
    loadMoreView.backgroundColor = mycolcor(red: 245, green: 245, blue: 245)
    
    //添加中间的环形进度条
    let activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    activityViewIndicator.color = UIColor.darkGray
    let indicatorX = loadMoreView.frame.size.width/2-activityViewIndicator.frame.width/2
    let indicatorY = loadMoreView.frame.size.height/2-activityViewIndicator.frame.height/2 - 15
    activityViewIndicator.frame = CGRect(x:indicatorX, y:indicatorY,
                                         width:activityViewIndicator.frame.width,
                                         height:activityViewIndicator.frame.height)
    activityViewIndicator.startAnimating()
    //bottom -> height
    let label = UILabel(frame: CGRect(x: 0, y: activityViewIndicator.height + 15
        , width: KscreenW(), height: 20))
    if loadMoreEnable {
        label.text = "正在加载中···"
    } else {
        label.text = "没有更多了···"
    }
    
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    label.textColor = UIColor.darkGray
    loadMoreView.addSubview(label)
    loadMoreView.addSubview(activityViewIndicator)
    return loadMoreView
    
}



/**
 设置状态栏背景颜色
 
 @param color 设置颜色
 */
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//
//        statusBar.backgroundColor = color;
//    }
//}

///设置状态栏背景颜色
func setStatusBarBackgroundColor(color : UIColor) {
    let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
    let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
    /*
     if statusBar.responds(to:Selector("setBackgroundColor:")) {
     statusBar.backgroundColor = color
     }*/
    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        statusBar.backgroundColor = color
    }
}














