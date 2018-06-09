//
//  SearchWebViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import WebKit
class SearchWebViewController: UIViewController {
    var navView:UIView?
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var lineView:UIView?
    var model: Content?
    var historyArr:NSMutableArray = []
    override func viewWillAppear(_ animated: Bool) {
        let path: String = Bundle.main.path(forResource: "searchHistory", ofType:"plist")!
        let array: NSMutableArray = NSMutableArray(contentsOfFile: path)!
        array.insert(["title":self.model?.rtitle,"url":self.model?.rurl], at: 0)
        array.write(toFile: path , atomically: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        self.navView = navView
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "gengduo"), for: .normal)
        self.navView?.addSubview(rightBtn)
        self.rightBtn = rightBtn
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorWithHexColorString("e6e6e6")
        self.navView?.addSubview(lineView)
        self.lineView = lineView
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let webview: WKWebView = WKWebView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), configuration: WKWebViewConfiguration())
        webview.load(URLRequest(url: URL(string: model!.rurl)!))
        webview.navigationDelegate = self
        self.view?.addSubview(webview)
        self.navView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(64)
        })
    }
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("网页开始接收网页内容")
//        webView.evaluateJavaScript("document.title") { (a, e) in
//            self.titleLab?.text = a as? String ?? ""
//        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("网页由于某些原因加载失败\(error)")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("网页\(error)")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
