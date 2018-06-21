//
//  FindViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class FindViewController: UIViewController,WKNavigationDelegate {
    var navView: UIView?
    var titleLab:UILabel?
    var progressView: UIProgressView?
    var webview: WKWebView?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if #available(iOS 11.0, *) {
            self.webview?.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navView = UIView()
        navView.backgroundColor = .colorAccent
        self.view.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui1"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.textAlignment = .center
        titleLab.textColor = .white
        self.titleLab = titleLab
        navView.addSubview(titleLab)
        
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(navView)
            make.width.height.equalTo(44)
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(backBtn)
            make.width.equalTo(navView).offset(-88)
            make.centerX.equalTo(navView)
        }
        let webview: WKWebView = WKWebView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), configuration: WKWebViewConfiguration())
        webview.load(URLRequest(url: URL(string: "http://daiduoduo.zhishensoft.com/h5/index/index?channel=10001")!))
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        self.view.bringSubview(toFront: navView)
        self.webview = webview
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "estimatedProgress" {
//            self.progressView?.progress = Float((self.webview?.estimatedProgress)!)
//            if self.progressView?.progress == Float(1) {
//                unowned let uSelf = self
//                UIView.animate(withDuration: 0.25, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                    uSelf.progressView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
//                }) { (finished) in
//                    uSelf.progressView?.isHidden = true
//                }
//            }else{
//                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            }
//        }
//    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        self.progressView?.isHidden = false
//        self.progressView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        self.view.bringSubview(toFront: self.progressView!)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("网页开始接收网页内容")
        webView.evaluateJavaScript("document.title") { (a, e) in
            self.titleLab?.text = a as? String ?? ""
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
       // self.progressView?.isHidden = true
        print("网页由于某些原因加载失败\(error)")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("网页\(error)")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       // self.progressView?.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    deinit {
//        self.webview?.removeObserver(self, forKeyPath: "estimatedProgress")
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
