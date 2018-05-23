//
//  HomeNavigationView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNavigationView: UIView,NibLoadable {
    @IBOutlet weak var searchBtn: AnimatableButton!
    @IBOutlet weak var scanBtn: UIButton!
    /// 搜索按钮点击
    var didSelectSearchButton: (()->())?
    /// 扫一扫按钮点击
    var didSelectCameraButton: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        searchBtn.setImage(UIImage(named: "sousuo"), for: .normal)
    }
    
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: -20, width: screenWidth, height: 150)
        }
    }
    /// 相机按钮点击
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        didSelectCameraButton?()
    }
    /// 搜索按钮点击
    @IBAction func searchButtonClicked(_ sender: AnimatableButton) {
        didSelectSearchButton?()
    }

}
