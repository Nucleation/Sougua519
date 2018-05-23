//
//  NovelFlowLayout.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/18.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelFlowLayout: UICollectionViewFlowLayout {
    var itemCount: Int!
    var attributeArray: Array<UICollectionViewLayoutAttributes> = []
    var collectionHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        attributeArray = []
        let itemWidth = (screenWidth - 20*3)/2
        var colHight: Array<CGFloat> = [self.sectionInset.top,self.sectionInset.bottom]
        for i in 0..<itemCount {
            let index: IndexPath = IndexPath(item: i, section: 0)
            let attris = UICollectionViewLayoutAttributes(forCellWith: index)
            var width: Int = 0
            var hight: CGFloat = 0
            if i == 0 {
                hight = 225
            }else if (i - Int(1)) % 4 < 2 {
                hight = 225
            }else{
                hight = 225
            }
            if colHight[0] <= colHight[1] {
                colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
                width = 0;
            }else{
                colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
                width = 1;
            }
            attris.frame = CGRect(x: 20 + (20 + itemWidth) * CGFloat(width), y: colHight[width]-hight, width: itemWidth, height: hight)
            if i == itemCount - 1 {
                collectionHeight = colHight[width]
            }
            attributeArray.append(attris)
            if (colHight[0]>colHight[1]) {
                self.itemSize = CGSize(width: itemWidth, height: (colHight[0]-30)*2/CGFloat(itemCount)-20)
            }else{
                self.itemSize = CGSize(width: itemWidth, height: (colHight[1]-30)*2/CGFloat(itemCount)-20)
            }
            
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
