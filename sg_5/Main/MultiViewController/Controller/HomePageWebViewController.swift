//
//  HomePageWebViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/23.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit

class HomePageWebViewController: UIViewController{
    var navView: UIView?
    var titleLab:UILabel?
    var model: HomePageNewsModel?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let navView = UIView()
        navView.backgroundColor = .colorAccent
        self.view.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.textAlignment = .center
        titleLab.textColor = .white
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
        let webview: WKWebView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        if model?.type == "0" {
            if (model?.newsContent) != nil {
                webview.loadHTMLString((model?.newsContent)!, baseURL: nil)
            }
        }else{
            if (model?.newsContent) != nil {
                webview.load(URLRequest(url: URL(string: (model?.newsContent)!)!))
            }
        }
        
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        self.view.bringSubview(toFront: navView)
        webview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(navView.snp.bottom)
        }
        self.titleLab = titleLab
        self.navView = navView
        // Do any additional setup after loading the view.
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension HomePageWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("网页开始接收网页内容")
        webView.evaluateJavaScript("document.title") { (a, e) in
            self.titleLab?.text = a as? String ?? ""
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("网页由于某些原因加载失败")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        if !webView.isLoading{
 
            if (webView.url?.absoluteString ?? "").contains("toutiao.com/"){
                let str = """
document.getElementsByClassName("banner-pannel pannel-top show-top-pannel")[0].parentNode.style.display="none";
document.getElementsByClassName("unflod-field__mask")[0].click();
document.getElementsByClassName("recommendation-container-new-article-test")[0].style.display="none";
document.getElementsByClassName("open-btn")[0].parentNode.parentNode.style.display="none";
document.getElementsByClassName("new-style-test-article-author")[0].style.display="none"
"""
                webView.evaluateJavaScript(str, completionHandler: nil)
            }
        }
    }
}
