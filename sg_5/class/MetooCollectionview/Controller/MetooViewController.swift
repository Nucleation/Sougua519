//
//  MetooViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/16.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SGPagingView

class MetooViewController: UIViewController {

    var metooHeadView: MetooHeadView?
    var pageTitleView: SGPageTitleView?
    var pageTitleArr: Array<String> = []
    var pageContentView: SGPageContentView?
    var titleNameArr: Array<String>?
    //操作视图
    var oprateView: MUOprateView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let metooHeadView = MetooHeadView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 84))
        metooHeadView.titleLabel?.text = "美图"
        self.view.addSubview(metooHeadView)
        self.metooHeadView = metooHeadView
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","矢量智能对象"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
        let urlStr = picGetClassify
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (json) in
            let array: NSMutableArray = []
            for title in json {
                array.add(title.1.stringValue)
            }
            // 标题名称的数组
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = UIColor.colortext1
            configuration.titleSelectedColor = UIColor.colorAccent
            configuration.indicatorColor = .clear
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 84, width: screenWidth, height: 40), delegate: self, titleNames: array as! [Any], configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            // 设置子控制器
            _ = array.flatMap({ (title) -> () in
                // 图片,组图
                let metooView = MetooCollectionViewController()
                metooView.category = title as? String
                self.addChildViewController(metooView)
                
            })
            // 内容视图
            self.pageContentView = SGPageContentView(frame: CGRect(x: 0, y: 124, width: screenWidth, height: self.view.height - 168), parentVC: self, childVCs: self.childViewControllers)
            self.pageContentView!.delegatePageContentView = self
            self.view.addSubview(self.pageContentView!)
            self.view.bringSubview(toFront: self.oprateView)
        }
    }
        // Do any additional setup after loading the view.
    //操作视图点击回调操作
    func oprateClick(sender: UIButton) {
        switch sender.tag {
        case 1:
            break
        case 2:
            let vc = MUMultiWindowController()
            MUMultiWindowViewModel.addNewViewControllerToNavigationController(viewController: self)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - SGPageTitleViewDelegate
extension MetooViewController: SGPageTitleViewDelegate, SGPageContentViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView!.setPageContentViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentView(_ pageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
