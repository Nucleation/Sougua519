//
//  MUNaigationViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MUNaigationViewController: UINavigationController {
    //已经打开的控制器
    var opendViewControllers: Array = [UIViewController]()
    //当前控制器Index
    var currentVisibleIndex: NSInteger = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
