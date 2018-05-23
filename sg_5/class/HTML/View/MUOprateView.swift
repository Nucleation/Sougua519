//
//  MUOprateView.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MUOprateView: UIView {
    var OprateBlock: (UIButton) -> Void = {_ in }
    //设置dataArray
    var dataArray: Array<Any>?{
        didSet{
            createSubView()
        }
    }
    //["1.png","2.png","3.png","4.png"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createSubView() {
        for index in 0..<dataArray!.count{
            let btn = UIButton(type: UIButtonType.custom)
            btn.setImage(UIImage(named: dataArray![index] as! String), for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
            btn.tag = index + 1
            if index == 2 {
                btn.imageEdgeInsets = UIEdgeInsets(top: -20, left: -10, bottom: 0, right: -10)
            }
            self.addSubview(btn)
        }
    }
    @objc func btnClick(sender: UIButton?) {
        OprateBlock(sender!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width/CGFloat(self.subviews.count)
        for index in 0..<self.subviews.count{
            self.subviews[index].frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: self.frame.height)
        }
    }
    //MARK: --控制tabbar按钮点击状态
    func subViewStatus(viewController:UIViewController){
//        let nav = viewController.navigationController as! MUNaigationViewController
//        let index = nav.currentVisibleIndex as NSInteger
//        for view in self.subviews {
//            if view is UIButton{
//                if index <= 1 && view.tag == 1{
//                    (viewController is HTMLViewController) && (viewController as! HTMLViewController).webView!.canGoBack ? ((view as! UIButton).isEnabled = true): ((view as! UIButton).isEnabled = false)
//                }
//            }else if index >= (nav.opendViewControllers.count) && view.tag == 2  {
//                (viewController is HTMLViewController) && (viewController as! HTMLViewController).webView!.canGoForward ? ((view as! UIButton).isEnabled = true): ((view as! UIButton).isEnabled = false)
//            }else{
//                (view as!UIButton).isEnabled = true
//            }
//        }
    }
}
