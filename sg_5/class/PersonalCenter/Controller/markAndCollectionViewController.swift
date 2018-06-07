//
//  markAndCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class markAndCollectionViewController: UIViewController {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var mainTab: UITableView!
    @IBOutlet weak var newFolder: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func leftBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
