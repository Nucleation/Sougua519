//
//  MuRootViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh
class MuRootViewController: UIViewController,UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CategoryButtonViewDelegate{
    //tableView
    var navigationBar = HomeNavigationView.loadViewFromNib()
    var searchBar: UISearchBar?
    var headView: UIView?
    
    //var mainScrollerView:UIScrollView?
    var searchView:UIView = {
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 90))
        searchView.backgroundColor = UIColor.lightGray
        return searchView
    }()
    var subSearchBar: UISearchBar?
    var subScanBtn:UIButton?
    
    
    var categoryButtonView:CategoryButtonView?
    var mainTableView: UITableView?
    
    let header = MJRefreshHeader()
    let footer = MJRefreshFooter()
    var newsList: Array = [HomePageNews]()
    //打开的网页
    var html: HTMLViewController?
    //操作视图
    var oprateView: MUOprateView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        html = HTMLViewController()
        MUMultiWindowViewModel.addNewViewControllerToNavigationController(viewController: self)
        self.title = "window"
        self.view.backgroundColor = UIColor.white
        setUI()
        NetworkTool.loadHomePageNewsData { newsList in
            self.newsList = newsList
            self.mainTableView?.reloadData()
        }
    }
    func setUI() {
        if self.responds(to: #selector(getter: automaticallyAdjustsScrollViewInsets)) {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        //上划后的searchBar
        self.view.addSubview(searchView)
        let subSearchBar = UISearchBar(frame: CGRect(x: 17, y: 27, width: screenWidth-80, height: 56))
        subSearchBar.placeholder = "输入搜索内容"
        subSearchBar.delegate = self
        subSearchBar.barTintColor = UIColor.white
        subSearchBar.backgroundColor = UIColor.white
        self.subSearchBar = subSearchBar
        self.searchView.addSubview(self.subSearchBar!)
        let subScanBtn = UIButton(type: .custom)
        subScanBtn.frame = CGRect(x: screenWidth - 63, y: 27, width: 56, height: 56)
        subScanBtn.setBackgroundImage(UIImage(named: "saoyisao"), for: .normal)
        subScanBtn.backgroundColor = UIColor.white
        subScanBtn.addTarget(self, action: #selector(scanBtnClick), for: .touchUpInside)
        self.subScanBtn = subScanBtn
        self.searchView.addSubview(self.subScanBtn!)
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth/5*2+190))
        self.headView = headView
        let searchBar = UISearchBar(frame: CGRect(x: 17, y: 80, width: screenWidth-80, height: 56))
        searchBar.placeholder = "输入搜索内容"
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        self.navigationBar.addSubview(searchBar)
        self.searchBar = searchBar
        self.headView?.addSubview(self.navigationBar)
        categoryButtonView = CategoryButtonView(frame: CGRect(x: 0, y: 150, width: screenWidth, height: screenWidth/5*2+40))
        categoryButtonView?.delegate = self
        self.headView?.addSubview(categoryButtonView!)
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-50))
        mainTableView?.bounces = false
        mainTableView?.delegate = self
        mainTableView?.dataSource = self
        mainTableView!.register(UINib(nibName:"ImageTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"Image")
        mainTableView!.register(UINib(nibName:"SingleImageTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"SingleImage")
        mainTableView!.register(UINib(nibName:"VideoTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"Video")
        mainTableView!.register(UINib(nibName:"VideoSubTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"VideoSub")
        mainTableView!.register(UINib(nibName:"SingleTestTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"SingleTest")
        self.view?.addSubview(mainTableView!)
        self.mainTableView?.mj_header = MJRefreshHeader(refreshingBlock: {
            print("下拉刷新")
            NetworkTool.loadHomePageNewsData { newsList in
                self.newsList = newsList
                self.mainTableView?.reloadData()
            }
            self.mainTableView?.mj_header.endRefreshing()
        })
        self.mainTableView?.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            print("加载更多")
            self.newsList += self.newsList
            self.mainTableView?.reloadData()
            self.mainTableView?.mj_footer.endRefreshing()
        })
        self.mainTableView?.tableHeaderView = self.headView
        
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","矢量智能对象"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //更新按钮状态
        self.oprateView.subViewStatus(viewController: self)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func scanBtnClick() {
        print("扫一扫")
    }
    //操作视图点击回调操作
    func oprateClick(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.mainTableView?.reloadData()
//            if let popVc = MUMultiWindowViewModel.popToViewController(viewController: self){
//                self.navigationController?.popToViewController(popVc, animated: true)
//            }
         case 2:
           
            let vc = MUMultiWindowController()
            self.navigationController?.pushViewController(vc, animated: true)
//            if let pushVc = MUMultiWindowViewModel.pushToViewController(viewController: self){
//                self.navigationController?.pushViewController(pushVc, animated: true)
//                }
        case 3:
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            break
        default:
            break
        }
    }
}
extension MuRootViewController{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var dataArr = SOsearch().getData(keyWord: searchText)
        dataArr += SougouSearch().getData(keyWord: searchText)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension MuRootViewController {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsList.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let anews = newsList[indexPath.row]
            switch anews.type {
            case "singletext":
                let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTest") as! SingleTestTableViewCell
                cell.aNews = anews
                return cell
            case "images":
                let cell = tableView.dequeueReusableCell(withIdentifier: "Image") as! ImageTableViewCell
                cell.aNews = anews
                return cell
            case "video":
                let cell = tableView.dequeueReusableCell(withIdentifier: "Video") as! VideoTableViewCell
                cell.aNews = anews
                return cell
            case "videosub":
                let cell = tableView.dequeueReusableCell(withIdentifier: "VideoSub") as! VideoSubTableViewCell
                cell.aNews = anews
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SingleImage") as! SingleImageTableViewCell
                cell.aNews = anews
                return cell
            }
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let aNews = newsList[indexPath.row]
            switch aNews.type {
            case "singletext":
                return 95
            case "image":
                return 200
            case "video":
                return 270
            case "videosub":
                return 150
            case "singleimage":
                return 160
            default:
                return 200
            }
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tabOffsetY:CGFloat = (self.mainTableView?.contentOffset.y)!
        if tabOffsetY >= 80 {
            UIView.animate(withDuration: 0.05) {
                self.view.bringSubview(toFront: self.searchView)
            }
        }else if tabOffsetY > 0 && tabOffsetY < 80{
            self.view.bringSubview(toFront: self.mainTableView!)
            self.view.bringSubview(toFront: self.oprateView)
           self.navigationBar.alpha = (80 - tabOffsetY)/80
        }
    }
    //MARK: --添加主页按钮
    func categoryBtnClick(sender: UIButton) {
        if sender.tag == 5 {
            let vc = NoveHomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = MetooViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
