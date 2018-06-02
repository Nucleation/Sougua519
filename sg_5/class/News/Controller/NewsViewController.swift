//
//  NewsViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/2.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //directType    是    string    新闻类型
        //timestamp    是    string    时间戳
        //sign    是    string    签名
        //page    否    string    分页信息（不传则默认第一页，每页查询14条）
        //id    否    string    视频id(如果传值返回的集合中不包含该视频;如果不传值，返回的集合中包含该视频)
        // Do any additional setup after loading the view.
        requestNewsType()
    }
    func requestNewsType() {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNewsTypeListUrl, parameters: parData) { (json) in
            print(json)
        }
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
