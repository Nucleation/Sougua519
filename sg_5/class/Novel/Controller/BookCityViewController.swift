//
//  BookCityViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import EmptyPage
import MJRefresh

protocol BookCityViewDelegate {
    func pushViewController(viewController: UIViewController)
}
class BookCityViewController: UIViewController{
    var delegate: BookCityViewDelegate?
    var pageTitleCollection: NovelCategoryCollectionView?
    var subCollection: NovelCategoryCollectionView?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 90, width: screenWidth, height: self.view.frame.height - 90), style: UITableViewStyle.plain)
        tableView.register(UINib(nibName:"NovelListTableViewCell", bundle:nil),
                           forCellReuseIdentifier:"cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestData()
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.requestMoreData()
        })
        self.view.addSubview(tableView)
        self.tableView = tableView
//        let view = EmptyPageView.ContentView.standard
//        // 自定义配置标准样式
//        view.configImageView(images: [UIImage(named: "333")!])
//        view.titleLabel.text = "Connection failure"
//        view.button.setTitle("TRY AGAIN", for: .normal)
//        // 将标准样式条添加至背景View上(提供了约束设置的功能)
//        let emptyView: EmptyPageView = .mix(view: view)
//        tableView.setEmpty(view: emptyView)
        return tableView
    }()
    var tabHeadView: UIView?
    var headView: UIView?
    var category: String = ""
    var subCategory: String = ""
    var pageIndex: Int = 1
    var dataArr: Array<NoveCategoryListModel> = [NoveCategoryListModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let headView = UIView()
        headView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
        self.view.addSubview(headView)
        self.headView = headView
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: noveGetCategorys, parameters: parData) { (json) in
            var array: Array = [NovelTitleModel]()
            let modelf = NovelTitleModel()
            modelf.title = "全部"
            modelf.itemIsSelected = true
            array.append(modelf)
            for title in json {
                let model = NovelTitleModel()
                model.title = title.1.stringValue
                model.itemIsSelected = false
                array.append(model)
            }
            let titleCollection = NovelCategoryCollectionView(frame: CGRect(x: 0, y: 20, width: screenWidth, height: 25), titleArr: array)
            titleCollection.backgroundColor = .white
            titleCollection.callBackBlock(block: { (str) in
                self.category = str
                self.requestData()
                self.tableView.reloadData()
            })
            self.headView?.addSubview(titleCollection)
            self.pageTitleCollection = titleCollection
            let subArrTitle: Array<String> = ["全部","完结","连载"]
            let isSelectArr: Array<Bool> = [true,false,false]
            var subArray: Array = [NovelTitleModel]()
            
            for i in 0 ..< 3 {
                let model = NovelTitleModel()
                model.title = subArrTitle[i]
                model.itemIsSelected = isSelectArr[i]
                subArray.append(model)
            }
            let subCollection = NovelCategoryCollectionView(frame: CGRect(x: 0, y: 45, width: screenWidth, height: 25), titleArr: subArray)
            subCollection.backgroundColor = .white
            subCollection.callBackBlock(block: { (str) in
                self.subCategory = str
                self.requestData()
                self.tableView.reloadData()
            })
            self.headView?.addSubview(subCollection)
            self.subCollection = subCollection
        }
        
        requestData()
        // Do any additional setup after loading the view.
    }
    func requestData() {
        self.pageIndex = 1
        self.dataArr = []
        let urlStr = getNovelListByPage
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        if self.category == "全部" {
            self.category = ""
        }
        if self.subCategory == "全部" {
            self.category = ""
        }
        if self.subCategory == "完结" {
            self.subCategory = "已完结"
        }
        if self.subCategory == "连载" {
            self.subCategory = "连载中"
        }
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"categoryName":self.category,"page":self.pageIndex,"fictionIsEnd": self.subCategory]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData) { (json) in
            self.dataArr.removeAll()
            if let datas = json["novelList"].arrayObject{
                self.dataArr += datas.compactMap({NoveCategoryListModel.deserialize(from: $0 as? Dictionary)})
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            
        }
    }
    func requestMoreData() {
        self.pageIndex += 1
        let urlStr = getNovelListByPage
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        if self.category == "全部" {
            self.category = ""
        }
        if self.subCategory == "全部" {
            self.category = ""
        }
        if self.subCategory == "完结" {
            self.subCategory = "已完结"
        }
        if self.subCategory == "连载" {
            self.subCategory = "连载中"
        }
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"categoryName":self.category,"page":self.pageIndex,"fictionIsEnd": self.subCategory]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData) { (json) in
            if let datas = json["novelList"].arrayObject{
                self.dataArr += datas.compactMap({NoveCategoryListModel.deserialize(from: $0 as? Dictionary)})
            }
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension BookCityViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NovelListTableViewCell
        cell.setCellwithModel(model: self.dataArr[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell   
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.dataArr[indexPath.row].id]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
            let vc = NovelInfoViewController()
            vc.novelInfo = self.dataArr[indexPath.row]
            if self.delegate != nil {
                self.delegate?.pushViewController(viewController: vc)
            }
            
        }
    }
}
