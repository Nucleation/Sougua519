//
//  SearchViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
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
    
    //操作视图
    var oprateView: MUOprateView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //更新按钮状态
        self.oprateView.subViewStatus(viewController: self)
        self.search(keyWord: self.keyWord ?? "")
        self.searchTF?.text = self.keyWord ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        self.navView = navView
        let searchTF = UITextField()
        searchTF.layer.borderWidth = 1
        searchTF.layer.cornerRadius = 3
        searchTF.layer.borderColor = UIColor.colorWithHexColorString("dddddd").cgColor
        searchTF.placeholder = "请输入搜索内容"
        searchTF.font = UIFont.systemFont(ofSize: 15)
        searchTF.leftViewMode = UITextFieldViewMode.always
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
        self.searchTF?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.navView!).offset(15)
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
        // Do any additional setup after loading the view.
    }
    @objc func searchClick(){
        self.dataArr = SOsearch().getData(keyWord: self.searchTF?.text ?? "")
        self.dataArr += SougouSearch().getData(keyWord: self.searchTF?.text ?? "")
        self.tableView?.reloadData()
    }
    func search(keyWord:String){
        self.dataArr = SOsearch().getData(keyWord: keyWord)
        self.dataArr += SougouSearch().getData(keyWord:keyWord)
        self.tableView?.reloadData()
    }
    //MARK:--操作视图点击回调操作
    func oprateClick(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.searchClick()
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
}
