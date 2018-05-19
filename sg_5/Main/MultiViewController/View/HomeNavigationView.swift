//
//  HomeNavigationView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class HomeNavigationView: UIView,NibLoadable {
    /// 固有的大小
//    override var intrinsicContentSize: CGSize {
//        return UILayoutFittingExpandedSize
//    }
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: -20, width: screenWidth, height: 150)
        }
    }

}
