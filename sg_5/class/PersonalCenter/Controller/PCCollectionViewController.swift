//
//  PCCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/12.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class PCCollectionViewController: UIViewController {
    var mainTab: UITableView!
    var dataArr: Array<CollectModel> = [CollectModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainTab = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), style: .plain)
        mainTab.delegate = self
        mainTab.dataSource = self
        mainTab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(mainTab)
        self.mainTab = mainTab
        let view = UIView()
        self.mainTab.tableFooterView = view
        
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
        let cell = UITableViewCell(style:.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataArr[indexPath.row].title
        cell.imageView?.image = UIImage(named: "bottom浏览器打开")
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
            let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.dataArr[indexPath.row].contentId,"mark": self.dataArr[indexPath.row].mark]
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    
    func  tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
    }
    
    
    func  tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
            let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"userId":KeyChain().getKeyChain()["id"]!,"id":self.dataArr[indexPath.row].id,"token":KeyChain().getKeyChain()["token"]!,"contentId":self.dataArr[indexPath.row].contentId]
            let parData = dic.toParameterDic()
            NetworkTool.requestData(.post, URLString: cancleCollectUrl, parameters: parData ) { (json) in
                
            }
            self.dataArr.remove(at: indexPath.row)
            self.mainTab!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }

}
