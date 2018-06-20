//
//  NoveCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh


class NoveCollectionViewController: UIViewController {
    let cellWidth: CGFloat = (screenWidth - 20*3)/2
    var category: String?
    var noveClassifyArray: Array = [NoveCategoryListModel]()
    var flowLayout: NovelFlowLayout?
    var pageIndex: Int = 1
    lazy var mainCollectionView: UICollectionView = {
        let flowLayout = NovelFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemCount = self.noveClassifyArray.count
        self.flowLayout = flowLayout
        let mainCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 164), collectionViewLayout: flowLayout)
        mainCollectionView.backgroundColor = UIColor.white
        mainCollectionView.register(NoveCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestData()
        })
        mainCollectionView.mj_header.ignoredScrollViewContentInsetTop = 10;
        mainCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadMoreData()
        })
        self.view.addSubview(mainCollectionView)
        return mainCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestData()
        // Do any additional setup after loading the view.
    }
    func loadMoreData(){
        self.pageIndex += 1
        let urlStr = getNovelListByPage
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval)]
        //["timestamp":String(timeInterval),"categoryName":self.category!,"page":String(self.pageIndex)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (json) in
           
            if let datas = json["novelList"].arrayObject{
                self.noveClassifyArray += datas.compactMap({NoveCategoryListModel.deserialize(from: $0 as? Dictionary)})
            }
            self.flowLayout?.itemCount = self.noveClassifyArray.count
            self.mainCollectionView.mj_footer.endRefreshing()
            self.mainCollectionView.reloadData()
        }
    }
    func requestData() {
        self.pageIndex = 1
        let urlStr = getNovelListByPage
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"categoryName":self.category!,"page":self.pageIndex]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData) { (json) in
            
            self.noveClassifyArray.removeAll()
            if let datas = json["novelList"].arrayObject{
                self.noveClassifyArray += datas.flatMap({NoveCategoryListModel.deserialize(from: $0 as? Dictionary)})
            }
             self.flowLayout?.itemCount = self.noveClassifyArray.count
            self.mainCollectionView.mj_header.endRefreshing()
            self.mainCollectionView.reloadData()
           
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension NoveCollectionViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.noveClassifyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoveCollectionViewCell
        //cell.collcetBtn?.setTitle(String(indexPath.row), for: .normal)
        cell.setCellWithModel(model: self.noveClassifyArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -30, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.noveClassifyArray[indexPath.row].id,"page": 1 ]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
            let vc = NovelInfoViewController()
            vc.novelInfo = self.noveClassifyArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
