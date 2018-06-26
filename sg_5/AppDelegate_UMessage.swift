//
//  AppDelegate_UMessage.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

extension AppDelegate:UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let nsdataStr = NSData.init(data: deviceToken)
        let datastr = nsdataStr.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print("deviceToken:\(datastr)")
        UMessage.registerDeviceToken(deviceToken)
    }
    func UMessage_application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
       
        //       友盟推送
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }        
        let entity = UMessageRegisterEntity()
        entity.types = Int(UMessageAuthorizationOptions.badge.rawValue) | Int(UMessageAuthorizationOptions.alert.rawValue)
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { b,e in
            if b{
                // 用户选择了接收Push消息
                myprint("-------             用户选择了接收Push消息")
            }else{
                // 用户拒绝接收Push消息
                myprint("-------             用户拒绝接收Push消息")
            }
        }
    }
    //    didReceiveRemoteNotification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            //应用处于前台时的远程推送接受
            //关闭友盟自带的弹出框
            UMessage.setAutoAlert(false)
            //必须加这句代码
            UMessage.didReceiveRemoteNotification(userInfo)
            userInfoAction(userInfo)
        }else{
            //应用处于前台时的本地推送接受
            userInfoAction(userInfo)
        }
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler([.badge , .sound , .alert])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            //应用处于后台时的远程推送接受
            //必须加这句代码
            UMessage.didReceiveRemoteNotification(userInfo)
            userInfoAction(userInfo)
        }else{
            //应用处于后台时的本地推送接受
            userInfoAction(userInfo)
        }
    }
    
    
    func userInfoAction(_ userInfo:[AnyHashable : Any]) {
        // 处理推送跳转网页
        //let appversion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        if var url = userInfo["url"] as? String{
            url = "http://www.baidu.com"
            if let _ = URL(string: url) {
                print(url)
                if let  _ = URL(string: url){       
                    pushJumWeb(url: url)
                }
            }
        }
    }
    func pushJumWeb(url:String) {
        
        let vc = FindViewController()
        vc.url = url
        let navC = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController?.present(navC, animated: true, completion: {
            
            
        })
    }
    
    func setPushAlias(name:String,type: String){
        UMessage.removeAlias(name, type: type) { responseObject,error in }
        UMessage.setAlias(name, type: type) { responseObject,error in }
    }
}
