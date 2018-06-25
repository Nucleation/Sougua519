//
//  AboutUSViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class AboutUSViewController: UIViewController {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var contentLab: UILabel!    
    @IBOutlet weak var versionLab: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
//        
        requestData()
    }
    func requestData(){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getAboutUSDataUrl, parameters: parData) { (json) in
            if json["code"] == "-1" {
                self.view.makeToast(json["msg"].stringValue)
            }else{
                self.versionLab.text = json[0]["title"].stringValue
                self.contentLab.text = json[0]["detail"].stringValue
                self.iconImage.kf.setImage(with: URL(string: json[0]["icon"].stringValue))
            }
            
        }
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
