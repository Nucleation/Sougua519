//
//  EpisodeViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import MJRefresh
class EpisodeViewController: UIViewController {
    var naviView: UIView?
    var tableView: UITableView?
    var episodeArray: Array<EpisodeModel> = [EpisodeModel]()
    //操作视图
    var oprateView: MUOprateView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //更新按钮状态
        self.oprateView.subViewStatus(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestData()
        })
        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.height.equalTo(screenHeight-64-44)
        })
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44))
        self.oprateView = oprateView
        oprateView.dataArray = ["shuaxin","xinjian","搜瓜","wode","发现"]
        oprateView.OprateBlock =  { sender in
            unowned let uSelf = self
            uSelf.oprateClick(sender: sender)
        }
        self.view.addSubview(oprateView)
        requestData()
        // Do any additional setup after loading the view.
    }
    func requestData(){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getEpisodeUrl, parameters: parData) { (json) in
            print(json)
            if let datas = json.arrayObject{
                self.episodeArray += datas.compactMap({EpisodeModel.deserialize(from: $0 as? Dictionary)})
            }
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.reloadData()
        }
    }
    //操作视图点击回调操作
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension EpisodeViewController: UITableViewDelegate,UITableViewDataSource,EpisodeTextCellDelegate,EpisodeImageCellDelegate,EpisodeVideoCellDelegate,UMSocialShareMenuViewDelegate{
    func textCellShare(sender: EpisodeTextCell) {
        let model = getModel(sender: sender)
        share(model: model)
    }
    
    func imageCellShare(sender: EpisodeImageCell) {
        let model = getModel(sender: sender)
        share(model: model)
    }
    
    func videoCellShare(sender: EpisodeVideoCell) {
        let model = getModel(sender: sender)
        share(model: model)
    }
    func share(model: EpisodeModel){
        UMSocialUIManager.setPreDefinePlatforms([NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue)])
        UMSocialUIManager.setShareMenuViewDelegate(self)
        UMSocialUIManager.showShareMenuViewInWindow(platformSelectionBlock: { (platformType, info) in
            var shareTitle = ""
            var share_pic = ""
            var url = ""
            if model.mark == "1"{
                let messageObject =  UMSocialMessageObject()
                messageObject.text = model.content
                UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self) { (data, error) in
                    if let error = error as NSError?{
                        print("取消分享 : \(error.description)")
                    }else{
                        print("分享成功")
                    }
                }
            }else if model.mark == "2" {
                share_pic = model.contentImg
                if model.title == "" {
                    shareTitle = model.content
                } else{
                    shareTitle = model.title
                }
                let messageObject =  UMSocialMessageObject()
                let shareObject = UMShareImageObject()
                let url = URL(string: model.contentImg )
                let data = try! Data(contentsOf: url!)
                //shareObject.thumbImage = UIImage(data: data)
                shareObject.shareImage = UIImage(data: data)
                messageObject.shareObject = shareObject;
                UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self) { (data, error) in
                    if let error = error as NSError?{
                        print("取消分享 : \(error.description)")
                    }else{
                        print("分享成功")
                    }
                }
            }else{
                if model.title != ""{
                    shareTitle = model.title
                }else{
                    shareTitle = model.source
                }
                url = model.videourl
                let desc = "来自搜瓜"
                let messageObject = UMSocialMessageObject()
                let pic = share_pic.replacingOccurrences(of: "http://", with: "https://")
                let shareObject = UMShareWebpageObject.shareObject(withTitle:shareTitle, descr: desc, thumImage:pic)
                shareObject?.webpageUrl = url
                messageObject.shareObject = shareObject
                UMSocialManager.default().share(to: platformType, messageObject:messageObject, currentViewController: self) { (data, error) in
                    if let error = error as NSError?{
                        print("取消分享 : \(error.description)")
                    }else{
                        print("分享成功")
                    }
                }
            }
            
        })
    }
    func umSocialParentView(_ defaultSuperView: UIView!) -> UIView! {
        return self.view
    }
    func textCellup(sender: EpisodeTextCell) {
        let model = getModel(sender: sender)
        self.upWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func textCelldown(sender: EpisodeTextCell) {
        let model = getModel(sender: sender)
        self.downWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func textCellcomment(sender: EpisodeTextCell) {
        //let model = getModel(sender: sender)
    }
    
    func imageCellup(sender: EpisodeImageCell) {
        let model = getModel(sender: sender)
         self.upWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func imageCelldown(sender: EpisodeImageCell) {
        let model = getModel(sender: sender)
        self.downWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func imageCellcomment(sender: EpisodeImageCell) {
        //let model = getModel(sender: sender)
    }
    
    func videoCellup(sender: EpisodeVideoCell) {
        let model = getModel(sender: sender)
         self.upWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func videoCelldown(sender: EpisodeVideoCell) {
        let model = getModel(sender: sender)
        self.downWithIdAndMark(id: model.id, mark: model.mark)
    }
    
    func videoCellcomment(sender: EpisodeVideoCell) {
        //let model = getModel(sender: sender)
    }
    
    func getModel(sender: Any) -> EpisodeModel {
        let index: IndexPath = (self.tableView?.indexPath(for: sender as! UITableViewCell))!
        return self.episodeArray[index.row]
    }
    func upWithIdAndMark(id: String,mark: String){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":id,"mark":mark]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: pictureUpUrl, parameters: parData) { (json) in
            if json["code"] == "1" {
                self.view.makeToast(json["msg"].stringValue)
            }
        }
    }
    func downWithIdAndMark(id: String,mark: String){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":id,"mark":mark]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: pictureDownUrl, parameters: parData) { (json) in
            if json["code"] == "1" {
                self.view.makeToast(json["msg"].stringValue)
            }
        }
    }
    func allBtnClick(sender: EpisodeTextCell) {
        DispatchQueue.main.async {
            let index: IndexPath = (self.tableView?.indexPath(for: sender))!
            let model = self.episodeArray[index.row]
            model.isShowAll = true
            self.tableView?.reloadRows(at: [index], with: .automatic)
            self.tableView?.layoutSubviews()
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
            //cell.setCellByModel(model: episide)
            cell.model = episide
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case "2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! EpisodeImageCell
            cell.model = episide
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! EpisodeVideoCell
            cell.model = episide
            cell.delegate = self
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
