//
//  HomeNavigationView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import IBAnimatable
protocol HomeNavigationViewDelegate {
    func goSearch()
}
class HomeNavigationView: UIView,NibLoadable {
    @IBOutlet weak var searchBtn: AnimatableButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    var delegate: HomeNavigationViewDelegate?
    
    /// 搜索按钮点击
    var didSelectSearchButton: (()->())?
    /// 扫一扫按钮点击
    var didSelectCameraButton: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        searchBtn.setImage(UIImage(named: "sousuo"), for: .normal)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        self.imageView.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor.colorAccent.cgColor, UIColor.colorWithHexColorString("66b3ee").cgColor]
        gradientLayer.locations = [0.0 , 1.0]
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
        self.delegate?.goSearch()
    }

}
