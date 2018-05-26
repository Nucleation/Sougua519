//
//  BookShelfViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol BookShelfViewDelegate {
    func BSPushViewController(viewController: UIViewController)
}

class BookShelfViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    var delegate: BookShelfViewDelegate?
    var bookArray:Array<NovelShelfListModel> = [NovelShelfListModel]()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = BookShelfFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemCount = self.bookArray.count + 1
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-90), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .red
        collectionView.register(BookShelfItem.self, forCellWithReuseIdentifier: "bookcell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //判断用户登录
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (time) in
                SVProgressHUD.show(withStatus: "未登录")
            }
            return
        }else{
            getDataArr()
            self.collectionView.reloadData()
           
        }
        //        if (self.delegate != nil) {
        //            self.delegate?.BSPushViewController(viewController: self)
        //        }
        // Do any additional setup after loading the view.
    }
    func getDataArr() {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!,"mobile":KeyChain().getKeyChain()["mobile"]!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelShelfListUrl, parameters: parData) { (json) in
            print("json--\(json)")
            if let data = NovelShelfBaseModel.deserialize(from: json){
                print(data)
            }
            
//            if let datas = json.arrayValue{
//                print(datas)
//                self.bookArray += datas.compactMap({NovelShelfListModel.deserialize(from: $0 as? Dictionary)})
//            }
           
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension BookShelfViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookArray.count + 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookShelfItem
        //cell.setLabColor(model: self.bookArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: 10, bottom: 10, right: 10)
    }
}
class BookShelfItem: UICollectionViewCell {
    var titleLab: UILabel?
    var imageView: UIImageView?
    var model: NovelShelfListModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        //self.setColor()
        self.backgroundColor = UIColor.randomColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        //self.itemLab?.textColor = self.isSelecte! ? .red : .black
    }
    func setUI(){
        //self.backgroundColor = .white
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 3
        //imageView.kf.setImage(with: URL(string: model!.delFlag))
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(50)
        }
        self.imageView = imageView
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 14)
        titleLab.textAlignment = NSTextAlignment.center
        self.addSubview(titleLab)
        self.titleLab = titleLab
        self.titleLab?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(25)
        })
        
    }
}

