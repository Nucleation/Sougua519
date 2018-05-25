//
//  NovelCategoryCollectionView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
typealias callTitleBlock = (_ str: String) -> Void
class NovelCategoryCollectionView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    var callBack: callTitleBlock?
    var collectionView: UICollectionView?
    var titleArr: Array<NovelTitleModel> = [NovelTitleModel]()
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect,titleArr: Array<NovelTitleModel>) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.titleArr = titleArr
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: self.frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        //layout.minimumLineSpacing = 10;
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(NovelCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        self.collectionView = collectionView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NovelCategoryCollectionViewCell
        cell.setLabColor(model: self.titleArr[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.titleArr[currentIndexPath.row ]
        model.itemIsSelected = false
        collectionView.reloadItems(at: [currentIndexPath])
        //self.titleArr[(currentIndexPath?.row)!] = model
        currentIndexPath = indexPath
        let model1 = self.titleArr[(currentIndexPath.row)]
        model1.itemIsSelected = true
        //self.titleArr[(currentIndexPath?.row)!] = model1
        collectionView.reloadItems(at: [currentIndexPath])
        if callBack != nil {
            callBack!(self.titleArr[currentIndexPath.row].title)
        }
    }
    func callBackBlock(block: @escaping (_ str: String) -> Void) {
        callBack = block
    }
}
class NovelCategoryCollectionViewCell: UICollectionViewCell {
    
    var itemLab: UILabel?
    var model: NovelTitleModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        //self.setColor()
        //self.backgroundColor = UIColor.randomColor
    }
    func setLabColor(model: NovelTitleModel){
        self.itemLab?.text = model.title
        self.itemLab?.textColor = model.itemIsSelected! ? .blue : .black
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        //self.itemLab?.textColor = self.isSelecte! ? .red : .black
    }
    func setUI(){
        self.backgroundColor = .white
        let itemLab = UILabel()
        itemLab.backgroundColor = .white
        itemLab.font = UIFont.systemFont(ofSize: 14)
        itemLab.textAlignment = NSTextAlignment.center
        self.addSubview(itemLab)
        self.itemLab = itemLab
        self.itemLab?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
    }
}
