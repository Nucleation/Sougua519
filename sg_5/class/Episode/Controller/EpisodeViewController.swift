//
//  EpisodeViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    var naviView: UIView?
    var tableView: UITableView?
    var episodeArray: Array<EpisodeModel> = [EpisodeModel]()
    //操作视图
    var oprateView: MUOprateView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        let naviView = MetooHeadView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        naviView.titleLabel?.text = "段子"
        self.view.addSubview(naviView)
        self.naviView = naviView
        let tableView = UITableView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"EpisodeImageCell", bundle:nil),
                           forCellReuseIdentifier:"ImageCell")
        tableView.register(UINib(nibName:"EpisodeVideoCell", bundle:nil),
                           forCellReuseIdentifier:"VideoCell")
        tableView.register(UINib(nibName:"EpisodeTextCell", bundle:nil),
                           forCellReuseIdentifier:"TextCell")
        tableView.rowHeight = UITableViewAutomaticDimension // 自适应单元格高度
        tableView.estimatedRowHeight = 50
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.height.equalTo(screenHeight-64-44)
        })
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","矢量智能对象"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
        // Do any additional setup after loading the view.
    }
    func requestData(){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getEpisodeUrl, parameters: parData) { (json) in
            print(json)
            if let datas = json.arrayObject{
                self.episodeArray += datas.compactMap({EpisodeModel.deserialize(from: $0 as? Dictionary)})
            }
            self.tableView?.reloadData()
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
extension EpisodeViewController: UITableViewDelegate,UITableViewDataSource,EpisodeTextCellDelegate{
    func allBtnClick(sender: EpisodeTextCell) {
        DispatchQueue.main.async {
            sender.allBtn.isHidden = true
            sender.contentLab.numberOfLines = 0
            let index: IndexPath = (self.tableView?.indexPath(for: sender))!
            self.tableView?.reloadRows(at: [index], with: .automatic)
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episide = self.episodeArray[indexPath.row]
        switch episide.mark {
        case "1":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! EpisodeTextCell
            cell.setCellByModel(model: episide)
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case "2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! EpisodeImageCell
            cell.setCellByModel(model: episide)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! EpisodeVideoCell
            cell.setCellByModel(model: episide)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  =  EpisodeInfoViewController()
        vc.model = self.episodeArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)   
    }
}
