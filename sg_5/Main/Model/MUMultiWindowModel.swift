//
//  MUMultiWindowModel.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MUMultiWindowModel: NSObject {
    //标题
    var title: String?
    //网站图标
    var icon: String?
    //图片
    var image:UIImage?
    //窗口
    var window: UIWindow?
    
    func initWithImageAndTitleAndIconAndwindow(image: UIImage, title: String, icon: String, window: UIWindow) -> (MUMultiWindowModel){
        let muMultiWindow = MUMultiWindowModel()
        muMultiWindow.image = image
        muMultiWindow.title = title
        muMultiWindow.icon = icon
        muMultiWindow.window = window
        return muMultiWindow    
    }
    
    
}
