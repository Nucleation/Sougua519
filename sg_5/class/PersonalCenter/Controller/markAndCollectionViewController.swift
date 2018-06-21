//
//  markAndCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//
import UIKit
import EmptyPage

class markAndCollectionViewController: UIViewController {
    @IBOutlet weak var titleLab: UILabel!
    var mainTab: UITableView?
    var model:Content?
    var dataArr:Array<ScanInfo> = []
    var scanModel = ScanModel()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        scanModel.loadData()
        self.dataArr = scanModel.scanList
        self.mainTab?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainTab = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), style: .plain)
        mainTab.delegate = self
        mainTab.dataSource = self
        mainTab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(mainTab)
        self.mainTab = mainTab
        let view = EmptyPageView.ContentView.onlyText
        view.label.text = "浏览记录为空"
        let emptyView: EmptyPageView = .mix(view: view)
        self.mainTab?.setEmpty(view: emptyView)
        let fview = UIView()
        self.mainTab?.tableFooterView = fview
        EmptyPage.begin()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leftBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension markAndCollectionViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style:.default, reuseIdentifier: "cell")
        let cell = UITableViewCell(style:.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataArr[indexPath.row].url
        cell.imageView?.image = UIImage(named: "scan")
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let web = SearchWebViewController()
        let model = Content()
        model.rtitle = self.dataArr[indexPath.row].title
        model.rurl = self.dataArr[indexPath.row].url
        web.model = model
        self.navigationController?.pushViewController(web, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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
            scanModel.loadData()
            scanModel.scanList.remove(at: indexPath.row)
            scanModel.saveData()
            self.dataArr = scanModel.scanList
            self.mainTab!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }

}
