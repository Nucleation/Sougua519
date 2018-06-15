//
//  markAndCollectionViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//
import UIKit

class markAndCollectionViewController: UIViewController {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var mainTab: UITableView!
    var model:Content?
    var dataArr:Array<ScanInfo> = []
    var scanModel = ScanModel()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        scanModel.loadData()
        self.dataArr = scanModel.scanList
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style:.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataArr[indexPath.row].url
        cell.imageView?.image = UIImage(named: "bottom浏览器打开")
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
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    private func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "点击删除"
    }
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            scanModel.loadData()
            scanModel.scanList.remove(at: indexPath.row)
            scanModel.saveData()
            //self.dataArr = scanModel.scanList
            self.mainTab!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }
}
