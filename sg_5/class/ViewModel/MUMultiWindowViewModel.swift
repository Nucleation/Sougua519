//
//  MUMultiWindowViewModel.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit
class MUMultiWindowViewModel: NSObject {
    /**
     * 重置navigationSubView 如果已经返回到root时再次点击清空以往打开过得VC，避免无限次累加返回后退
     @param viewController <#viewController description#>
     */
    static func resetNavigationSubController(viewController: UIViewController){
        let nav = (viewController.navigationController) as! MUNaigationViewController
        if nav.currentVisibleIndex == 1 {
            let mainArr = [nav.opendViewControllers.first]
            nav.opendViewControllers.removeAll()
            nav.opendViewControllers = mainArr as! Array<UINavigationController>
            nav.viewControllers = mainArr as! [UIViewController]
        }
    }
    /**
     * 添加保存新打开的控制器
     @param viewController 新控制器
     */
    static func addNewViewControllerToNavigationController(viewController: UIViewController){
        let nav = UIApplication.shared.keyWindow?.rootViewController as! MUNaigationViewController
        if nav.currentVisibleIndex == 1 && viewController is HTMLViewController {
            let mainArr = [nav.opendViewControllers.first]
            nav.opendViewControllers.removeAll()
            nav.opendViewControllers = mainArr as! Array<UINavigationController>
        }
        if viewController is MuRootViewController && nav.opendViewControllers.count != 0 {
            nav.opendViewControllers.insert(viewController, at: 0)
        }
        nav.opendViewControllers.append(viewController)
        nav.currentVisibleIndex += 1
    }
    /**
     * 调整首页在显示栈中的位置
     @param viewController <#viewController description#>
     */
    static func updateNavigationViewController(viewController: UIViewController){
        let nav = UIApplication.shared.keyWindow?.rootViewController as! MUNaigationViewController
        var subArr = nav.viewControllers
        var temp: Array<Any>?
        for subVc: UIViewController in subArr {
            if subVc is MuRootViewController {
                temp?.append(subVc)
            }
        }
        subArr.removeObjectInArray(array: subArr)
        subArr.append(nav.opendViewControllers.first as! UIViewController)
        nav.viewControllers = subArr
   
    }
    /**
     * 返回操作
     @param viewController <#viewController description#>
     @return <#return value description#>
     */
    static func popToViewController(viewController: UIViewController) ->(UIViewController?){
        let nav = UIApplication.shared.keyWindow?.rootViewController as! MUNaigationViewController
        if nav.currentVisibleIndex - 2 < 0 || (nav.opendViewControllers.count) == 0 {
            return nil
        }
        let index:NSInteger = nav.currentVisibleIndex - 2
        let vc = nav.opendViewControllers[index]
        if vc is HTMLViewController || vc is MuRootViewController && nav.viewControllers.contains(vc) {
            var arr = nav.viewControllers
            let index = (arr.count > 0) ? (arr.count - 1) : 0
            arr.insert(vc , at: index)
            nav.viewControllers = arr
            
        }
        nav.currentVisibleIndex -= 1
        return vc
    }
    /**
     * 前进操作
     @param viewController <#viewController description#>
     @return <#return value description#>
     */
    static func pushToViewController(viewController:UIViewController) -> (UIViewController?){
        let nav = UIApplication.shared.keyWindow?.rootViewController as! MUNaigationViewController
        let index = nav.currentVisibleIndex
        if nav.currentVisibleIndex == nav.opendViewControllers.count {
            return nil
        }
        let vc = nav.opendViewControllers[index]
        if nav.viewControllers.contains(vc) {
            var arr = nav.viewControllers
            arr.removeAll()
            nav.viewControllers = arr
        }
            nav.currentVisibleIndex += 1
        return vc
   
    }
}

