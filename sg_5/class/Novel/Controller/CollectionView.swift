//
//  CollectionView.swift
//  CollectionViewTest
//
//  Created by jinghe on 2018/5/24.
//  Copyright © 2018年 jinghe. All rights reserved.
//

import UIKit

class CollectionView: UIView {
    var collection: UICollectionView?
    var dataArr: Array <String> = ["1","2","3","4","2","3","4","2","3","4","2","3","4","2","3","4"]
    var flowLayout: BookShelfFlowLayout?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI() {
        let flowLayout = BookShelfFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemCount = self.dataArr.count
        self.flowLayout = flowLayout
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collection.backgroundColor = .red
        collection.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
        collection.delegate = self
        collection.dataSource = self
        collection.alwaysBounceVertical = true
        collection.showsHorizontalScrollIndicator = false
        self.addSubview(collection)
        self.collection = collection
       
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (time) in
                self.dataArr += ["1","2","3","4"]
                print(self.dataArr.count)
                self.flowLayout?.itemCount = self.dataArr.count
                //            DispatchQueue.main.async {
                self.collection?.reloadData()
                //            }
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
extension CollectionView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.isSelected = true
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: [indexPath.row])
        cell?.backgroundColor = .blue
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: [indexPath.row])
        cell?.backgroundColor = .red
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 40, height: self.frame.height)
    }
}
class ItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
