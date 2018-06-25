//
//  SearchViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh
import NVActivityIndicatorView

class SearchViewController: UIViewController ,UITextFieldDelegate{
    var navView: UIView?
    var searchTF: UITextField?
    var searchBtn: UIButton?
    var dataArr:[Content] = []
    var rtitle: String = ""
    var rurl: String = ""
    var rcon: String = ""
    let cellId = "cell"
    let cellId1 = "cell1"
    var tableView :UITableView?
    var keyWord: String?
    var dataModel = DataModel()
    var backBtn: UIButton?
    //操作视图
    var oprateView: MUOprateView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //更新按钮状态
        self.oprateView.subViewStatus(viewController: self)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        self.navView = navView
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.navView?.addSubview(backBtn)
        self.backBtn = backBtn
        let searchTF = UITextField()
        searchTF.layer.borderWidth = 1
        searchTF.layer.cornerRadius = 3
        searchTF.layer.borderColor = UIColor.colorWithHexColorString("dddddd").cgColor
        searchTF.placeholder = "请输入搜索内容"
        searchTF.font = UIFont.systemFont(ofSize: 15)
        searchTF.delegate = self
        searchTF.leftViewMode = UITextFieldViewMode.always
        searchTF.returnKeyType = .search
        self.navView?.addSubview(searchTF)
        let imageView = UIImageView(frame: CGRect(x: 18, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "souzuo")
        searchTF.leftView = imageView
        self.searchTF = searchTF
        let searchBtn = UIButton(type: .custom)
        searchBtn.layer.borderWidth = 1
        searchBtn.layer.borderColor = UIColor.colorWithHexColorString("dddddd").cgColor
        searchBtn.setTitleColor(.colorAccent, for: .normal)
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        searchBtn.setTitle("搜瓜一下", for: .normal)
        searchBtn.addTarget(self, action: #selector(searchClick), for: .touchUpInside)
        self.navView?.addSubview(searchBtn)
        self.searchBtn = searchBtn
        self.navView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(64)
        })
        self.backBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.navView!).offset(0)
            make.height.width.equalTo(44)
            make.bottom.equalTo(self.navView!.snp.bottom)
        })
        self.searchTF?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.backBtn!.snp.right).offset(0)
            make.height.equalTo(38)
            make.bottom.equalTo(self.navView!).offset(-5)
            make.right.equalTo(self.searchBtn!.snp.left).offset(1)
        })
        self.searchBtn?.snp.makeConstraints({ (make) in
            make.height.bottom.equalTo(self.searchTF!)
            make.right.equalTo(self.navView!).offset(-15)
            make.width.equalTo(90)
        })
        let tableView = UITableView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension // 自适应单元格高度
        tableView.estimatedRowHeight = 50
        tableView.register(UINib(nibName: "mainTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.searchClick()
        })
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.navView!.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
        })
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","发现"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
        self.search(keyWord: self.keyWord ?? "")
        self.searchTF?.text = self.keyWord ?? ""
        // Do any additional setup after loading the view.
    }
    
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchClick(){
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        let nva = NVActivityIndicatorView(frame: CGRect(x: screenWidth/2 - 30 , y: screenHeight/2 - 40, width: 60, height: 80), type: .pacman, color: UIColor.colorAccent, padding: 0)
        view.addSubview(nva)
        UIApplication.shared.keyWindow?.addSubview(view)
        nva.startAnimating()
        dataModel.loadData()
        dataModel.historyList.append(Histroy(his: self.searchTF?.text ?? ""))
        dataModel.saveData()
        self.dataArr = SOsearch().getData(keyWord: self.searchTF?.text ?? "")
        self.dataArr += SougouSearch().getData(keyWord: self.searchTF?.text ?? "")
        self.tableView?.mj_header.endRefreshing()
        self.tableView?.reloadData()
        nva.stopAnimating()
        view.removeFromSuperview()
    }
    func search(keyWord:String){
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        let nva = NVActivityIndicatorView(frame: CGRect(x: screenWidth/2 - 30 , y: screenHeight/2 - 40, width: 60, height: 80), type: .pacman, color: UIColor.colorAccent, padding: 0)
        view.addSubview(nva)
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
        //UIApplication.shared.keyWindow?.addSubview(view)
        nva.startAnimating()
        self.view.endEditing(true)
        self.dataArr = SOsearch().getData(keyWord: keyWord)
        self.dataArr += SougouSearch().getData(keyWord:keyWord)
        self.tableView?.reloadData()
        nva.stopAnimating()
        view.removeFromSuperview()
    }
    //MARK:--操作视图点击回调操作
    func oprateClick(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.tableView?.mj_header.beginRefreshing()
        case 2:
            let vc = MUMultiWindowController()
            MUMultiWindowViewModel.addNewViewControllerToNavigationController(viewController: self)
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            self.navigationController?.popToRootViewController(animated: false)
        case 4:
            let vc = PersonalCenterViewController.loadStoryboard()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = FindViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else {
            return true
        }
        searchClick()
        self.view.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! mainTableViewCell
        let con = self.dataArr[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLab?.attributedText = con.rtitle.removeHeadAndTailSpacePro.stringToAttribute(keyWord: self.searchTF!.text!)
        cell.contentLab?.attributedText = con.rcon.removeHeadAndTailSpacePro.stringToAttribute(keyWord: self.searchTF!.text!)
        cell.urlLab?.attributedText = con.rurl.removeHeadAndTailSpacePro.stringToAttribute(keyWord: self.searchTF!.text!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let web = SearchWebViewController()
        let con = self.dataArr[indexPath.row]
        web.model = con
        self.navigationController?.pushViewController(web, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
