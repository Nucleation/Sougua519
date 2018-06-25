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
    var titleLab:UILabel?
    var lineView:UIView?
    var model: Content?
    var webview: WKWebView?
    
    var scanModel = ScanModel()
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(65), width: UIScreen.main.bounds.width, height: 2))
        self.progressView.tintColor = UIColor.colorAccent      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    override func viewWillAppear(_ animated: Bool) {
        scanModel.loadData()
        scanModel.scanList.append(ScanInfo(title: self.model?.rtitle ?? "", url: self.model?.rurl ?? ""))
        scanModel.saveData()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        self.navView = navView
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.textAlignment = .center
        titleLab.textColor = .black
        self.titleLab = titleLab
        navView.addSubview(titleLab)
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
        self.navView?.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let webview: WKWebView = WKWebView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), configuration: WKWebViewConfiguration())
        webview.load(URLRequest(url: URL(string: model!.rurl)!))
        webview.navigationDelegate = self
        self.view?.addSubview(webview)
        self.webview = webview
        self.view.addSubview(progressView)
        self.webview?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.navView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(64)
        })
        self.titleLab?.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(self.leftBtn!)
            make.width.equalTo(navView).offset(-100)
            make.centerX.equalTo(navView)
        }
        self.leftBtn?.snp.makeConstraints({ (make) in
            make.left.bottom.equalToSuperview()
            make.width.height.equalTo(44)
        })
    }
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    deinit {
        self.webview?.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview?.uiDelegate = nil
        self.webview?.navigationDelegate = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchWebViewController: WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float((self.webview?.estimatedProgress)!), animated: true)
            if Float((self.webview?.estimatedProgress)!) >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("网页开始接收网页内容")
        webView.evaluateJavaScript("document.title") { (a, e) in
            self.titleLab?.text = a as? String ?? ""
        }
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
