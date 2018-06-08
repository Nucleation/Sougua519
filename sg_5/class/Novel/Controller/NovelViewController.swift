//
//  NovelViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/24.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import SGPagingView

class NovelViewController: UIViewController,UIScrollViewDelegate,BookCityViewDelegate,BookShelfViewDelegate {
    var oprateView: MUOprateView!
    var scrollView: UIScrollView?
    var headView: NovelHomeHeadView?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createUI()
        
    }
    func createUI() {
        let headView = NovelHomeHeadView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        headView.delegate = self
        self.view.addSubview(headView)
        self.headView = headView
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 60, width: screenWidth, height: screenHeight-104))
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: screenWidth*2, height: screenHeight - 104)
        let bookShelf = BookShelfViewController(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight-104))
        bookShelf.delegate = self
        let bookCity = BookCityViewController()
        bookCity.delegate = self
        bookCity.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-104)
        scrollView.addSubview(bookShelf)
        scrollView.addSubview(bookCity.view)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","发现"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
        self.oprateView = oprateView

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            self.headView?.bookCity?.sendActions(for: .touchUpInside)
        }else if scrollView.contentOffset.x == screenWidth {
            self.headView?.bookshelf?.sendActions(for: .touchUpInside)
        }
        
    }
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
            self.navigationController?.popToRootViewController(animated: false)
        case 4:
            if KeyChain().getKeyChain()["isLogin"] == "1"{
                let vc = PersonalCenterViewController.loadStoryboard()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
    func pushViewController(viewController:UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    func BSPushViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func goToBookCity() {
        self.headView?.bookCity?.sendActions(for: .touchUpInside)
    }
}
extension NovelViewController: NovelHeadViewDelegate{
    func backBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bookCityClick() {
        self.scrollView?.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
    }
    
    func bookshelfClick() {
        self.scrollView?.setContentOffset(CGPoint(x:screenWidth , y: 0), animated: true)
    }
}
