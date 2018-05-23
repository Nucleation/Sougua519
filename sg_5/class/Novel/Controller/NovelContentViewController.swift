//
//  NovelContentViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelContentViewController: UIViewController,UIGestureRecognizerDelegate{
    
    var content:String = ""
    var tap: UITapGestureRecognizer?
    //弹出视图
    var popView: UIView?
    var isPopViewShow: Bool = false
    var sectionBtn: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backImageView: UIImageView = UIImageView(frame: self.view.bounds)
        backImageView.image = UIImage(named: "novelBGI")
        self.view.addSubview(backImageView)
        self.tap = UITapGestureRecognizer(target: self, action: #selector(webViewTap(sender:)))
        self.tap?.delegate = self
        let webview: UIWebView = UIWebView(frame: self.view.frame)
        webview.loadHTMLString(content, baseURL: nil)
        webview.backgroundColor = .clear
        webview.isOpaque = false
        webview.addGestureRecognizer(self.tap!)
        self.view.addSubview(webview)
        // Do any additional setup after loading the view.
    }
    @objc func webViewTap(sender: UIWebView){
        if !isPopViewShow {
            if self.popView == nil{
                createPopView()
                self.isPopViewShow = true
            }else{
                self.isPopViewShow = true
                UIView.animate(withDuration: 1) {
                    self.popView?.snp.updateConstraints({ (make) in
                        make.left.right.bottom.equalTo(self.view)
                        make.height.equalTo(60)
                    })
                }
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 1) {
                self.popView?.snp.updateConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.height.equalTo(0)
                })
            }
            self.view.layoutIfNeeded()
            self.isPopViewShow = false
        }
    }
    func createPopView(){
        let popView = UIView()
        popView.backgroundColor = .black
        popView.alpha = 0.8
        self.view.addSubview(popView)
        self.popView = popView
        UIView.animate(withDuration: 1) {
            self.popView?.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalTo(self.view)
                make.height.equalTo(60)
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.tap {
            return true
        }else{
            return false
        }
    }
}
