//
//  AppDelegate.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var firstWindow: MultiWindow?
    var isLogin: Bool = false
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UMConfigure.initWithAppkey("5b1ddc83a40fa358f9000058", channel: nil)
        UMConfigure.setLogEnabled(true)
        configUSharePlatforms()
        confitUShareSettings()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.resignKey()
        window?.isHidden = true
        window?.rootViewController = nil
        firstWindow = MultiWindow(frame: UIScreen.main.bounds)
        firstWindow?.windowLevel = UIWindowLevelNormal
        firstWindow?.rootViewController = MUNaigationViewController(rootViewController: MuRootViewController())
        firstWindow?.makeKeyAndVisible()
        UMessage_application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    func configUSharePlatforms() {
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: StaticNumerical.sharder.QQAppKey, appSecret: StaticNumerical.sharder.QQAppSecret, redirectURL: "")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.qzone, appKey: StaticNumerical.sharder.QQAppKey, appSecret: StaticNumerical.sharder.QQAppSecret, redirectURL: "")
        //UMSocialManager.default().removePlatformProvider(with: .tim)
        UMSocialManager.default().removePlatformProvider(with: .wechatFavorite)
        UMSocialManager.default().removePlatformProvider(with: .wechatSession)
        UMSocialManager.default().removePlatformProvider(with: .wechatTimeLine)
        
    }
    
    func confitUShareSettings() {
        
        
        
        /*
         * 打开图片水印
         */
        //        UMSocialGlobal.shareInstance().isUsingWaterMark = true
        /*
         * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         */
        //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
class StaticNumerical: NSObject {
    static let sharder = StaticNumerical_guaniu()
}

class StaticNumerical_guaniu: NSObject {
    var appname = "搜瓜"
    /*  测试地址 */
    //let AppConfig_BaseUrlValue = apiUrl1 // 正式地址
    let buglyId = "135c25dfc0"
    let UMessageAppkey = "5b1ddc83a40fa358f9000058"
    /* 微信QQ分享  */
    let SessionAppKey = "wxac6c048175533f71"
    let SessionAppSecret = "7927a0a4815e96514048f5ddecfe9766"
    let QQAppKey = "1106889385"
    let QQAppSecret = "XJxeObz9fTpnSxt5"
    
}
