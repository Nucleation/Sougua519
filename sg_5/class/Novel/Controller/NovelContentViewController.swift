//
//  NovelContentViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelContentViewController: UIViewController,UIGestureRecognizerDelegate{
    var web: UIWebView?
    var novelContentModel:NovelContentModel?
    var tap: UITapGestureRecognizer?
    var novelId: String?
    var pageIndex: Int = 1
    
    //弹出视图
    var popView: UIView?
    var topPopView:UIView?
    //top
    var titleLab: UILabel?
    var backBtn: UIButton?
    //bottom
    var lastChapterBtn: UIButton?
    var nextChapterBtn: UIButton?
    var chapterListBtn: UIButton?

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
        webview.loadHTMLString(self.novelContentModel?.content ?? "", baseURL: nil)
        webview.backgroundColor = .clear
        webview.isOpaque = false
        webview.addGestureRecognizer(self.tap!)
        self.view.addSubview(webview)
        self.web = webview
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
                    self.topPopView?.snp.updateConstraints({ (make) in
                        make.left.right.top.equalTo(self.view)
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
                self.topPopView?.snp.updateConstraints({ (make) in
                    make.left.right.top.equalTo(self.view)
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
        self.view.addSubview(popView)
        self.popView = popView
//        var lastChapterBtn: UIButton?
//        var nextChapterBtn: UIButton?
//        var chapterListBtn: UIButton?
        let lastChapterBtn = UIButton(type: .custom)
        lastChapterBtn.layer.cornerRadius = 5
        lastChapterBtn.setTitle("上一章", for: .normal)
        lastChapterBtn.setTitleColor(.white, for: .normal)
        lastChapterBtn.backgroundColor = .colorAccent
        lastChapterBtn.addTarget(self, action: #selector(lastChapterBtnClick), for: .touchUpInside)
        self.popView?.addSubview(lastChapterBtn)
        self.lastChapterBtn = lastChapterBtn
        let chapterListBtn = UIButton(type: .custom)
        chapterListBtn.layer.cornerRadius = 5
        chapterListBtn.setTitle("章节", for: .normal)
        chapterListBtn.setTitleColor(.white, for: .normal)
        chapterListBtn.backgroundColor = .colorAccent
        chapterListBtn.addTarget(self, action: #selector(chapterListBtnClick), for: .touchUpInside)
        self.popView?.addSubview(chapterListBtn)
        self.chapterListBtn = chapterListBtn
        let nextChapterBtn = UIButton(type: .custom)
        nextChapterBtn.layer.cornerRadius = 5
        nextChapterBtn.setTitle("下一章", for: .normal)
        nextChapterBtn.setTitleColor(.white, for: .normal)
        nextChapterBtn.backgroundColor = .colorAccent
        nextChapterBtn.addTarget(self, action: #selector(nextChapterBtnClick), for: .touchUpInside)
        self.popView?.addSubview(nextChapterBtn)
        self.nextChapterBtn = nextChapterBtn
        UIView.animate(withDuration: 1) {
            self.popView?.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalTo(self.view)
                make.height.equalTo(50)
            })
            self.lastChapterBtn?.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self.popView!).offset(8)
                make.height.equalTo(self.popView!).offset(-16)
                make.right.equalTo(self.chapterListBtn!.snp.left).offset(-24)
            })
            self.chapterListBtn?.snp.makeConstraints({ (make) in
                make.centerY.width.height.equalTo(self.lastChapterBtn!)
                make.centerX.equalTo(self.popView!)
                make.right.equalTo(self.nextChapterBtn!.snp.left).offset(-24)
            })
            self.nextChapterBtn?.snp.makeConstraints({ (make) in
                make.centerY.width.height.equalTo(self.lastChapterBtn!)
                make.right.equalTo(self.popView!).offset(-8)
            })
        }
        let topPopView = UIView()
        topPopView.backgroundColor = .black
        self.view.addSubview(topPopView)
        self.topPopView = topPopView
        let titleLab = UILabel()
        titleLab.text = self.novelContentModel?.sectionName
        titleLab.textColor = .white
        titleLab.font = UIFont.systemFont(ofSize: 15)
        self.topPopView?.addSubview(titleLab)
        self.titleLab = titleLab
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.topPopView?.addSubview(backBtn)
        self.backBtn = backBtn
        UIView.animate(withDuration: 1) {
            self.topPopView?.snp.makeConstraints({ (make) in
                make.left.right.top.equalTo(self.view)
                make.height.equalTo(60)
            })
            self.backBtn?.snp.makeConstraints({ (make) in
                make.left.bottom.equalTo(self.topPopView!)
                make.width.height.equalTo(self.topPopView!.snp.height).offset(-20)
                
            })
            self.titleLab?.snp.makeConstraints({ (make) in
                make.centerY.height.equalTo(self.backBtn!)
                make.centerX.equalTo(self.topPopView!)
            })
        }
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func lastChapterBtnClick(){
        if self.pageIndex > 2 {
            getContentByPage(page: self.pageIndex - 1,isNext: false)
        }else{
           self.view.makeToast("到顶了")
        }
        
    }
    @objc func chapterListBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func nextChapterBtnClick(){
        getContentByPage(page: self.pageIndex + 1, isNext: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getContentByPage(page: Int, isNext: Bool){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"id":self.novelId ?? "","page":String(page)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
            if json["code"] == "-1" {
                self.view.makeToast(json["msg"].stringValue)
            }else{
                if isNext {
                    self.pageIndex += 1
                }else{
                    self.pageIndex -= 1
                }
                
                let model = NovelContentModel.deserialize(from: json.dictionaryObject)
                self.web?.loadHTMLString(model?.content ?? "", baseURL: nil)
            }
            
            
           
    }
    
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.tap {
            return true
        }else{
            return false
        }
    }
}
