//
//  thirdPartyShareViewController.swift
//  JGD
//
//  Created by 徐秀秀  on 2017/2/25.
//  Copyright © 2017年 785236145666@163.com. All rights reserved.
//

import UIKit

/*
    显示分享面板
 */

func UMSocialUIManagerShowShareMenuViewInWindow(currentViewController:UIViewController,type:Int? = 1){
    UMSocialUIManager.showShareMenuViewInWindow { (platformType,userInfo) in
        switch platformType{
        case .sina:
            print("sina")
        case .wechatSession:
            print("wechatSession")
        case .wechatTimeLine:
            print("wechatTimeLine")
        case .QQ:
            print("QQ")
        default:break
        }
        
//        DispatchQueue.main.async {
         shareWebPageToPlatformType(platformType: platformType, currentViewController: currentViewController, type: type)
//        }
    }
}


/*
 分享文本
 */
func shareTextToPlatformType(platformType:UMSocialPlatformType,currentViewController:UIViewController){
    let messageObject =  UMSocialMessageObject()
    messageObject.text = "社会化组件UShare将各大社交平台接入您的应用，快速武装App。"
    UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: currentViewController) { (data, error) in
        if let error = error as NSError?{
            print("取消分享 : \(error.description)")
        }else{
            print("分享成功")
        }
    }
}
/*
 分享网页
 */
func shareWebPageToPlatformType(platformType:UMSocialPlatformType,currentViewController:UIViewController,type:Int? = 1){
    var url = UserDefaults.standard.object(forKey: "shareUrl") as!String
    if url == "" {
        url = "http://www.baidu.com"
    }
    var desc = UserDefaults.standard.object(forKey: "share_content") as!String
    let shareTitle = "[邀请]"
    let share_pic = UserDefaults.standard.object(forKey: "share_pic") as!String
    if type == 2 {
        desc = "您的好友发来一个邀请，请查看。"
    }

    
    let messageObject = UMSocialMessageObject()
    
    let pic = share_pic.replacingOccurrences(of: "http://", with: "https://")
    let shareObject = UMShareWebpageObject.shareObject(withTitle:shareTitle, descr: desc, thumImage:pic)
    shareObject?.webpageUrl = url
    messageObject.shareObject = shareObject
    UMSocialManager.default().share(to: platformType, messageObject:messageObject, currentViewController: currentViewController) { (data, error) in
        if let error = error as NSError?{
            print("取消分享 : \(error.description)")
        }else{
            print("分享成功")
        }
    }
}




