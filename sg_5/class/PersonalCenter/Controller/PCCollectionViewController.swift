//
//  PCCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/12.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class PCCollectionViewController: UIViewController {
    @IBOutlet weak var mainTab: UITableView!
    var dataArr: Array<CollectModel> = [CollectModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTab.delegate = self
        self.mainTab.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    func getData() {
        self.dataArr = []
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getCollectsUrl, parameters: parData ) { (json) in
            if let datas = json.arrayObject{
               self.dataArr  += datas.compactMap({CollectModel.deserialize(from: $0 as? Dictionary)})
            }
            self.mainTab.reloadData()
        }
    }
    @IBAction func backBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PCCollectionViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style:.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataArr[indexPath.row].title
        cell.imageView?.image = UIImage(named: "personalcenter我的收藏")
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dataArr[indexPath.row].type == "1" {
            print(ContentType.News.rawValue)
            let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
            let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.dataArr[indexPath.row].contentId]
            let parData = dic.toParameterDic()
            NetworkTool.requestData(.post, URLString: getNewsByIDUrl, parameters: parData ) { (json) in
                let webVC = HomePageWebViewController()
                webVC.model = HomePageNewsModel.deserialize(from: json.dictionaryValue)
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }else if self.dataArr[indexPath.row].type == "5"{
            print(ContentType.Episode.rawValue)
            let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
            let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.dataArr[indexPath.row].contentId]
            let parData = dic.toParameterDic()
            NetworkTool.requestData(.post, URLString: getEpisodeByIDUrl, parameters: parData ) { (json) in
                let webVC = EpisodeInfoViewController()
                webVC.model = EpisodeModel.deserialize(from: json.dictionaryValue)
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
//    private  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
//    {
//        return true
//    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    private func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "点击删除"
    }
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataArr.remove(at: indexPath.row)
            self.mainTab!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }
}
