//
//  BookShelfFlowLayout.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/26.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class BookShelfFlowLayout: UICollectionViewFlowLayout {
    var itemCount: Int!
    var attributeArray: Array<UICollectionViewLayoutAttributes> = []
    var collectionHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        attributeArray = []
        let itemWidth = (screenWidth - 20*4)/3
        let itemHeight = (screenWidth - 20*4)/3 * 235/175 + 50
        for i in 0..<itemCount {
            let index: IndexPath = IndexPath(item: i, section: 0)
            let attris = UICollectionViewLayoutAttributes(forCellWith: index)
            attris.frame = CGRect(x: 20 + (20 + itemWidth) * CGFloat(i % 3), y: 20+(20+itemHeight) * CGFloat(i / 3 % 3), width: itemWidth, height: itemHeight)
            attributeArray.append(attris)
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
           
        }
        
    }
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: collectionHeight)
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
}
