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
    var dataArr:[Content] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        let path: String = Bundle.main.path(forResource: "searchHistory", ofType:"plist")!
        let array = NSArray(contentsOfFile: path)! as! NSMutableArray
        if array.count != 0 {
            for i in 0..<array.count{
                let model = Content()
                let dic: Dictionary<String,String> = array[i] as! Dictionary
                model.rtitle = dic["title"]!
                model.rurl = dic["url"]!
                model.rcon =  ""
                model.rimg = ""
                self.dataArr += [model]
            }
        }
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
        cell.textLabel?.text = self.dataArr[indexPath.row].rurl
        cell.imageView?.image = UIImage(named: "bottom浏览器打开")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let web = SearchWebViewController()
        let con = self.dataArr[indexPath.row]
        web.model = con
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
            self.dataArr.remove(at: indexPath.row)
            self.mainTab!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            let path: String = Bundle.main.path(forResource: "searchHistory", ofType:"plist")!
            let array = NSArray(contentsOfFile: path)! as! NSMutableArray
            array.removeObject(at: indexPath.row)
            array.write(toFile: path, atomically: true)
        }
    }
}
