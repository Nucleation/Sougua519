//
//  BookShelfViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

protocol BookShelfViewDelegate {
    func BSPushViewController(viewController: UIViewController)
}

class BookShelfViewController: UIViewController {
    var delegate: BookShelfViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
//        if (self.delegate != nil) {
//            self.delegate?.BSPushViewController(viewController: self)
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
