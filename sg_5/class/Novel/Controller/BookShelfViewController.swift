//
//  BookShelfViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

protocol BookShelfViewDelegate {
    func BSPushViewController(viewController: UIViewController)
    func goToBookCity()
    func reloadData()
}

class BookShelfViewController: UIView, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var delegate: BookShelfViewDelegate?
    var bookArray:Array<NovelShelfBaseModel> = [NovelShelfBaseModel()]
    var flowLayout: BookShelfFlowLayout?
    var collectionView: UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
        let flowLayout = BookShelfFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemCount = self.bookArray.count
        self.flowLayout = flowLayout
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-90), collectionViewLayout:flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(BookShelfItem.self, forCellWithReuseIdentifier: "bookcell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longHand:)))
        collectionView.addGestureRecognizer(longPress)
        self.addSubview(collectionView)
       
        //collectionView.mj_header.ignoredScrollViewContentInsetTop = 10;
//        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//            self.loadMoreData()
//        })
        self.collectionView = collectionView
        //判断用户登录
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            if #available(iOS 10.0, *) {
                 self.makeToast("未登录")
            } else {
                // Fallback on earlier versions
            }
            return
        }else{
            requestData()
           
        }
        //        if (self.delegate != nil) {
        //            self.delegate?.BSPushViewController(viewController: self)
        //        }
        // Do any additional setup after loading the view.
    }
    func requestData() {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!,"mobile":KeyChain().getKeyChain()["mobile"]!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelShelfListUrl, parameters: parData) { (json) in
            print("json--\(json)")
            self.bookArray.removeAll()
            self.bookArray.append(NovelShelfBaseModel())
            if let datas = json.arrayObject{
                print(datas)
                datas.compactMap({NovelShelfBaseModel.deserialize(from: $0 as? Dictionary)}).forEach({ (model) in
                    self.bookArray.insert(model, at: 0)
                })
            }
            self.flowLayout?.itemCount = self.bookArray.count
            self.collectionView?.reloadData()
        }
    }
}
extension BookShelfViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookShelfItem
        cell.setItemByModel(model: self.bookArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.bookArray.count - 1{
        if (self.delegate != nil) {
            self.delegate?.goToBookCity()
           }
        }else{
            let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
            let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.bookArray[indexPath.row].novel?.id ?? ""]
            let parData = dic.toParameterDic()
            NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
                let vc = NovelInfoViewController()
                vc.novelInfo = (self.bookArray[indexPath.row].novel)!
                if self.delegate != nil {
                    self.delegate?.BSPushViewController(viewController: vc)
                }
                
            }
        }
    }
    @objc func longPress(longHand:UILongPressGestureRecognizer){
        switch (longHand.state) {
        case UIGestureRecognizerState.began:
            let indexPath = self.collectionView?.indexPathForItem(at: longHand.location(in: self.collectionView))
            if indexPath == nil || indexPath?.row == self.bookArray.count - 1  {
                return
            }else{
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "您确定要从书架删除吗？", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
                    let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":self.bookArray[indexPath!.row].id,"token":KeyChain().getKeyChain()["token"]!,"mobile":KeyChain().getKeyChain()["mobile"]!]
                    let parData = dic.toParameterDic()
                    NetworkTool.requestData(.post, URLString: deleteNovelShelfUrl, parameters: parData) { (json) in
                        if self.delegate != nil{
                            self.delegate?.reloadData()
                        }
                        
                    }
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        default:
            return
        }
    }
}
class BookShelfItem: UICollectionViewCell {
    var titleLab: UILabel?
    var imageView: UIImageView?
    var model: NoveCategoryListModel?
    var delBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setItemByModel(model:NovelShelfBaseModel){
        if model.id != "" {
            self.imageView?.kf.setImage(with: URL(string: model.novel?.fictionImg ?? ""))
            self.titleLab?.text = model.novel?.fictionName
        }else{
            self.imageView?.image = UIImage(named: "shujiaAdd")
        }
       
    }
    func setUI(){
        //self.backgroundColor = .white
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 3
        
        //imageView.kf.setImage(with: URL(string: model!.delFlag))
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
        self.imageView = imageView
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 14)
        titleLab.numberOfLines = 2
        titleLab.textAlignment = NSTextAlignment.center
        self.addSubview(titleLab)
        self.titleLab = titleLab
        self.titleLab?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(50)
        })
        
    }
}

