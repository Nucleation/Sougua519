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
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            self.pageIndex += 1
            self.getNewsList(pageNO: self.pageIndex)
            self.tableView.mj_footer.endRefreshing()
        })
    }
    func getNewsList(pageNO: Int){
        if self.pageIndex == 1 {
            self.newsListArr = []
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"directType":self.category!,"page":String(self.pageIndex)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNewsListByTypeUrl, parameters: parData) { (json) in
            //print(json["news"].arrayObject)
            if let datas = json["newsList"].arrayObject{
                self.newsListArr += datas.compactMap({HomePageNewsModel.deserialize(from: $0 as? Dictionary)})
            }   
            self.tableView?.reloadData()
            if self.pageIndex == 1{
                self.tableView?.contentOffset = CGPoint.zero
            }
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
