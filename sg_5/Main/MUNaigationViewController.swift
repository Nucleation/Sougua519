//
//  MUNaigationViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MUNaigationViewController: UINavigationController,UINavigationControllerDelegate {
    var popDelegate: UIGestureRecognizerDelegate?
    //已经打开的控制器
    var opendViewControllers: Array = [UIViewController]()
    //当前控制器Index
    var currentVisibleIndex: NSInteger = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.isEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        self.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    
    override func viewDidAppear(_ animated:Bool) {
     self.interactivePopGestureRecognizer?.isEnabled = false
    }
    //UINavigationControllerDelegate方法
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
