//
//  NewsTableViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/6.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh
class NewsTableViewController: UITableViewController {
    var pageIndex: Int = 1
    var category: String?
    var newsListArr: Array = [HomePageNewsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        getNewsList(pageNO: pageIndex)
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName:"ImageTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"Image")
        tableView.register(UINib(nibName:"SingleImageTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"SingleImage")
        tableView.register(UINib(nibName:"VideoTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"Video")
        tableView.register(UINib(nibName:"VideoSubTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"VideoSub")
        tableView.register(UINib(nibName:"SingleTestTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"SingleTest")
        tableView.mj_header = MJRefreshHeader(refreshingBlock: {
            self.pageIndex = 1
            self.getNewsList(pageNO: self.pageIndex)
            
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            self.pageIndex += 1
            self.getNewsList(pageNO: self.pageIndex)
            
        })
        tableView.rowHeight = UITableViewAutomaticDimension // 自适应单元格高度
        tableView.estimatedRowHeight = 50
    }
    func getNewsList(pageNO: Int){
        if self.pageIndex == 1 {
            self.newsListArr = []
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"directType":self.category!,"page":self.pageIndex]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNewsListByTypeUrl, parameters: parData) { (json) in
            //print(json["news"].arrayObject)
            if let datas = json["news"].arrayObject{
                self.newsListArr += datas.compactMap({HomePageNewsModel.deserialize(from: $0 as? Dictionary)})
            }   
            self.tableView?.reloadData()
            if self.pageIndex == 1{
                self.tableView?.contentOffset = CGPoint.zero
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsListArr.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aNews = newsListArr[indexPath.row]
        switch aNews.modelType {
        case "1":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTest") as! SingleTestTableViewCell
            cell.selectionStyle = .none
            cell.aNews = aNews
            return cell
        case "2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleImage") as! SingleImageTableViewCell
            cell.selectionStyle = .none
            cell.aNews = aNews
            return cell
        case "3":
            let cell = tableView.dequeueReusableCell(withIdentifier: "Video") as! VideoTableViewCell
            cell.selectionStyle = .none
            cell.aNews = aNews
            return cell
        case "4":
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoSub") as! VideoSubTableViewCell
            cell.selectionStyle = .none
            cell.aNews = aNews
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "Video") as! VideoTableViewCell
            cell.selectionStyle = .none
            cell.aNews = aNews
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let aNews = newsListArr[indexPath.row]
//        switch aNews.modelType {
//        case "1":
//            return 95
//        case "2":
//            return 120
//        case "3":
//            return 320
//        case "4":
//            return 120
//        default:
//            return 320
//        }
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.newsListArr[indexPath.row].directType == "组图" {
            var imageURLs = self.newsListArr[indexPath.row].newsContent.components(separatedBy: ";")
            imageURLs.removeLast()
            let multiPictureVC = MultiPictureViewController()
            multiPictureVC.imageURLArr = imageURLs
            self.navigationController?.pushViewController(multiPictureVC, animated: true)
            
        }else{
            let webVC = HomePageWebViewController()
            webVC.model = newsListArr[indexPath.row]
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }


}
