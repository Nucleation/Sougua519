//
//  HomeNavigationView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import IBAnimatable
import Alamofire

protocol HomeNavigationViewDelegate {
    func goSearch()
}
class HomeNavigationView: UIView,NibLoadable {
    @IBOutlet weak var searchBtn: AnimatableButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    
    @IBOutlet weak var visLab: UILabel!
    @IBOutlet weak var condtxtLab: UILabel!
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var temLab: UILabel!
    var city:String?
    var cond_txt:String?
    var tmp:String?
    var vis:String?
    var delegate: HomeNavigationViewDelegate?
    
    /// 搜索按钮点击
    var didSelectSearchButton: (()->())?
    /// 扫一扫按钮点击
    var didSelectCameraButton: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        getWeather()
        
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
    

    @IBAction func localBtnClick(_ sender: Any) {
        getWeather()
    }
    func getWeather(){
        let geturl = "https://free-api.heweather.com/s6/weather/now?location=auto_ip&key=b3e4ba8fdd664318a2a7de2a9c1a1b7e"
        
        Alamofire.request(geturl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //是否请求成功
            switch response.result{
                
            case .success(_):
                if let jsons = response.result.value{
                    let jsonDic = JSON(jsons)
                    self.city = jsonDic["HeWeather6"][0]["basic"]["location"].stringValue
                    self.tmp = jsonDic["HeWeather6"][0]["now"]["tmp"].stringValue
                    self.vis = jsonDic["HeWeather6"][0]["now"]["vis"].stringValue
                    self.cond_txt = jsonDic["HeWeather6"][0]["now"]["cond_txt"].stringValue
                    self.cityLab.text = self.city
                    self.temLab.text = "\(self.tmp ?? "")º"
                    self.visLab.text = "能见度\(self.vis ?? "")公里"
                    self.condtxtLab.text = self.cond_txt
                }
                
            case .failure(_):
                break
            }
        }
        
    }
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 150)
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
