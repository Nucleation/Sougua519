//
//  MetooCollectionViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/5/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh

//let header = MJRefreshNormalHeader()

class MetooCollectionViewController: UIViewController{
    //var mainCollectionView: UICollectionView?
    let cellWidth: CGFloat = (screenWidth - 20*3)/2
    var category: String?
    var pictureClassifyArray: Array = [PictureClassifyModel]()
    var flowLayout:JHFlowLayout?
    var pageIndex: Int = 0
    
    lazy var mainCollectionView: UICollectionView = {
        let flowLayout = JHFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemCount = self.pictureClassifyArray.count
        self.flowLayout = flowLayout
        let mainCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 164), collectionViewLayout: flowLayout)
        mainCollectionView.backgroundColor = UIColor.white
        mainCollectionView.register(MetooCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    }
    func loadMoreData(){
         self.pageIndex += 1
        let urlStr = picGetImgByClassify
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"category":self.category!,"pageIndex":String( self.pageIndex),"pageSize":String(20)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (json) in
           
            if let datas = json["list"].arrayObject{
                self.pictureClassifyArray += datas.compactMap({PictureClassifyModel.deserialize(from: $0 as? Dictionary)})
            }
            self.flowLayout?.itemCount = self.pictureClassifyArray.count
            self.mainCollectionView.mj_footer.endRefreshing()
            self.mainCollectionView.reloadData()
        }
    }
    func requestData() {
        self.pageIndex = 0
        let urlStr = picGetImgByClassify
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"category":self.category!,"pageIndex":String(self.pageIndex),"pageSize":String(20)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (json) in
            
            self.pictureClassifyArray.removeAll()
            if let datas = json["list"].arrayObject{
                self.pictureClassifyArray += datas.compactMap({PictureClassifyModel.deserialize(from: $0 as? Dictionary)})
            }
            self.flowLayout?.itemCount = self.pictureClassifyArray.count
            self.mainCollectionView.mj_header.endRefreshing()
            self.mainCollectionView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MetooCollectionViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureClassifyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MetooCollectionViewCell
        cell.collcetBtn?.setTitle(String(indexPath.row), for: .normal)
        cell.setCellWithModel(model: self.pictureClassifyArray[indexPath.row])
        cell.setImageViewHeight(indexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -30, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MetooScrollViewController()
        vc.pictureModelArr = self.pictureClassifyArray
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0 {
//            return  CGSize(width: cellWidth, height: 210)
//        }else if (indexPath.row - Int(1)) % 4 < 2 {
//            return CGSize(width: cellWidth, height: 260)
//        }else{
//           return  CGSize(width: cellWidth, height: 210)
//        }
//    }
}

