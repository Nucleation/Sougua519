//
//  MUmultiWindowFlowlayout.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol MUMultiWindowFlowlayoutDelegate:NSObjectProtocol {
    func updateBlurForRow(blur: CGFloat, row: NSInteger)
}


class MUmultiWindowFlowlayout: UICollectionViewFlowLayout {
    //卡片宽度
    let cellWitdth: CGFloat = SCREEN_WIDTH - 40
    //卡片高度
    let cellHeight: CGFloat = SCREEN_HEIGHT - 150
    var offsetY:CGFloat?
    var contentSizeHeight: CGFloat!
    var blurList: Array! = [CGFloat]()
    var delegate:MUMultiWindowFlowlayoutDelegate?
    var screenHeight: CGFloat = SCREEN_HEIGHT
    //当第0个cell从初始位置，往上滑m0个点时，卡片移动到最顶端
    var m0: CGFloat = 1000
    //contentOffset.y为0时，第0个cell的y坐标为0
    var n0: CGFloat = 100
    //每个cell之间的偏移量间距，第0个cell往下滑动deltaOffsetY个点时会达到第1个cell的位置
    var deltaOffsetY: CGFloat = 220
    //存放每个cell的attributes的数组
    var cellLayoutList: Array = [UICollectionViewLayoutAttributes]()
    //是否是第一个
    var isFrist: Bool!
    //多窗口的数量
    var multiWindowCount: Int!
    init(offsetY: CGFloat) {
        super.init()
        self.isFrist = true
        self.offsetY = offsetY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepare() {
        super.prepare()
        self.cellLayoutList .removeAll()
        let rowCount: NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        for row in 0..<rowCount {
            let attribute = self.layoutAttributesForItem(at: IndexPath(row: row, section: 0))
            cellLayoutList.append(attribute!)
        }
        
    }
    override var collectionViewContentSize: CGSize{
        return CGSize(width: (self.collectionView?.frame.size.width)!, height: getContentSizeY())
    }
    
    // 目标offset，在应用layout的时候会调用这个回调来设置collectionView的contentOffset
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 0, y: offsetY!)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array:Array = [UICollectionViewLayoutAttributes]()
        for attribute in cellLayoutList {
            if attribute.frame.intersects(rect){
                array.append(attribute)
            }
        }
        return array
    }
    //每次手指滑动时，都会调用这个方法来返回每个cell的布局
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //let rowCount = collectionView?.numberOfItems(inSection: 0)
        return getAttributesWhen3orMoreRows(indexPath:indexPath)
        
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return !newBounds.equalTo((self.collectionView?.bounds)!)
    }
    //cell的布局
    func getAttributesWhen3orMoreRows(indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath) as UICollectionViewLayoutAttributes
        attributes.size = CGSize(width: cellWitdth, height: cellHeight)
        var firstY:CGFloat = 0
        firstY = (collectionView?.contentOffset.y)!
        //计算位置
        let originY = getOriginYWithOffsetY(offsetY: firstY, row: indexPath.row)
        let centerY = originY + (collectionView?.contentOffset.y)! + cellHeight/2.0
        attributes.center = CGPoint(x: (collectionView?.frame.size.width)!/2, y: centerY)
        //计算缩放比例
        let rat = transformRatio(originY: originY)
        attributes.transform = CGAffineTransform(scaleX: rat, y: rat)
        //计算透明度
        var blur: CGFloat = 0
        if (1 - 1.14 * rat)<0 {
            blur = 0
        }else{
            blur = CGFloat(powf(Float(1 - 1.14*rat), 0.4))
        }
        blurList.insert(blur, at: indexPath.row)
        if (self.delegate != nil) {
            self.delegate?.updateBlurForRow(blur: blur, row: indexPath.row)
        }
        //这里设置zIndex，是为了cell的层次顺序达到下面的cell覆盖上面的cell的效果
        attributes.zIndex = Int(originY)
        return attributes
        
    }
    func getContentSizeY() -> CGFloat {
        self.contentSizeHeight = getSizeY()
        return self.contentSizeHeight
    }
    func getSizeY() -> CGFloat {
        let rowCount = self.collectionView?.numberOfItems(inSection: 0)
        let scrllY = self.deltaOffsetY * CGFloat(rowCount! - 1)
        return scrllY + self.screenHeight
        
    }
    //根据下标，当前偏移量来获取对应的y坐标
    func getOriginYWithOffsetY(offsetY:CGFloat,row:NSInteger) -> CGFloat {
        let x = offsetY
        let ni = defaultYWithRow(row: row)
        let mi = m0 + CGFloat(row) * deltaOffsetY
        let tmp = mi - x
        var y:CGFloat = 0
        if tmp >= 0 {
            y = CGFloat(powf((Float(tmp/mi)), 4) * Float(ni))
        }else{
            y = 0 - (cellHeight - tmp)
        }
        return y
        
    }
    //获取contentOffset.y = 0时每个cell的y值
    func defaultYWithRow(row: NSInteger) -> CGFloat {
        let x0: CGFloat = 0
        let xi = x0 - deltaOffsetY * CGFloat(row)
        let ni = powf(Float((m0 - xi)/m0), 4) * Float(n0)
        return CGFloat(ni)
    }
    //根据偏移量，下标获取对应的尺寸变化
    func transformRatio(originY: CGFloat) -> CGFloat {
        if originY < 0 {
            return 1
        }
        let range = UIScreen.main.bounds.height
        var originY = originY
        originY = CGFloat(fminf(Float(originY), Float(range)))
        let ratio = powf(Float(originY/range), 0.04)
        return CGFloat(ratio)
    }
}
