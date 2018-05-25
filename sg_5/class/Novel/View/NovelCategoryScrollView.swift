////
////  NovelCategoryScrollView.swift
////  sg_5
////
////  Created by zhishen－mac on 2018/5/24.
////  Copyright © 2018年 zhishen－mac. All rights reserved.
////
//
//let cateGoryView = NovelCategoryScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40), pageTitleArr: array as! Array<String>)
//self.view.addSubview(cateGoryView)
//import UIKit
//
//class NovelCategoryScrollView: UIView {
//    var scrollView: UIScrollView?
//    var contentView: UIView?
//    var lastButton: UIButton?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    init(frame: CGRect, pageTitleArr: Array<String>) {
//       super.init(frame: frame)
//        let scrollerView = UIScrollView()
//        scrollerView.contentInsetAdjustmentBehavior = .never
//        scrollerView.isPagingEnabled = true
//        scrollerView.showsHorizontalScrollIndicator = false
//        scrollerView.alwaysBounceVertical = false
//        self.addSubview(scrollerView)
//        self.scrollView = scrollerView
//        let contentView = UIView()
//        scrollerView.addSubview(contentView)
//        self.contentView = contentView
//        self.scrollView?.snp.makeConstraints({ (make) in
//            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        })
//        for i in 0 ..< pageTitleArr.count {
//            let button = UIButton(type: .custom)
//            button.setTitle(pageTitleArr[i], for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//            button.setTitleColor(UIColor.black, for: .normal)
//            button.setTitleColor(UIColor.red, for: .selected)
//            button.tag = i
//            
//            self.contentView?.addSubview(button)
//            button.snp.makeConstraints { (make) in
//                make.top.bottom.equalTo(self.contentView!)
//                make.height.equalTo(self)
//                if lastButton != nil {
//                    make.left.equalTo(self.lastButton!.snp.right).offset(10)
//                }else{
//                    button.isSelected = true
//                    make.left.equalTo(self.contentView!).offset(10)
//                }
//            }
//            self.lastButton = button
//        }
//        self.contentView?.snp.makeConstraints({ (make) in
//            make.edges.equalTo(self.scrollView!).inset(UIEdgeInsets.zero)
//            make.height.equalTo(self.scrollView!)
//            make.right.equalTo(self.lastButton!.snp.right).offset(10)
//        })
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
