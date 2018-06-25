//
//  SearchHistoryViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import EmptyPage
import NVActivityIndicatorView
class SearchHistoryViewController: UIViewController ,UITextFieldDelegate{
    var navView: UIView?
    var backBtn: UIButton?
    var searchTF: UITextField?
    var searchBtn: UIButton?
    var historyArr:Array<Histroy> = []
    var tableView :UITableView?
    var dataModel = DataModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        dataModel.loadData()
        self.historyArr = dataModel.historyList
         EmptyPage.begin()
        self.tableView?.reloadData()
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
        searchTF.returnKeyType = .search
        searchTF.delegate = self
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
        let headView = UIView()
        let lab = UILabel()
        lab.text = "历史记录"
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.colortext1
        headView.addSubview(lab)
        let button = UIButton(type: .custom)
        button.setTitle("清除历史记录", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clearData), for: .touchUpInside)
        button.setTitleColor(UIColor.colorAccent, for: .normal)
        headView.addSubview(button)
        lab.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
        }
        button.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(100)
        }
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        let view = EmptyPageView.ContentView.onlyText
        view.label.text = "历史记录为空"
        let emptyView: EmptyPageView = .mix(view: view)
        tableView.setEmpty(view: emptyView)
        let fview = UIView()
        tableView.tableFooterView = fview
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
        })
        
        
        // Do any additional setup after loading the view.
    }
    @objc func clearData(){
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您确定要清除记录吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.historyArr = []
            self.dataModel.historyList = []
            self.dataModel.saveData()
            self.tableView?.reloadData()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    @objc func searchClick(){
        self.view.endEditing(true)
        if self.searchTF?.text != "" {
            dataModel.historyList.append(Histroy(his: self.searchTF?.text ?? ""))
            dataModel.saveData()
            dataModel.loadData()
            self.historyArr = dataModel.historyList
            //self.tableView?.reloadData()
            let vc = SearchViewController()
            vc.keyWord = self.searchTF?.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "搜索内容不能为空", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .cancel, handler: {
                action in
                
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTF?.resignFirstResponder()
        guard textField.text != "" else {
            return true
        }
        searchClick()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style:.default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = self.historyArr[indexPath.row].his
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let vc = SearchViewController()
        vc.keyWord = cell?.textLabel?.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    
    func  tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
    }
    
    
    func  tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.historyArr.remove(at: indexPath.row)
            dataModel.historyList = self.historyArr
            dataModel.saveData()
            self.tableView!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }
}
