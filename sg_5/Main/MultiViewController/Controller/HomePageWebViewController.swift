//
//  HomePageWebViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/23.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SVProgressHUD
class HomePageWebViewController: UIViewController,UIWebViewDelegate {
    var webURL: String = ""
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(navView)
            make.width.height.equalTo(44)
        }
        let webview: UIWebView = UIWebView(frame: self.view.frame)
        webview.loadRequest(URLRequest(url: URL(string: webURL)!))
        webview.backgroundColor = .clear
        webview.delegate = self
        webview.isOpaque = false
        self.view.addSubview(webview)
        self.view.bringSubview(toFront: navView)
        // Do any additional setup after loading the view.
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
