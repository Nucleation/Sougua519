//
//  EpisodeInfoViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import BMPlayer

class EpisodeInfoViewController: UIViewController {
    var model:EpisodeModel?    
    var headView: UIView?
    var navView:UIView?
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var lineView:UIView?
    //var videoView:UIView?
    //info
    var backView:UIView?
    var userIcon: UIView?
    var sourceLab: UILabel?
    var timeLab: UILabel?
    var focusBtn: UIButton?
    var contentLab: UILabel?
    var contentImageView: UIImageView?
    var upBtn: UIButton?
    var shareBtn: UIButton?
    //tableView
   
    var tableView: UITableView?
    var hView:EpisodeInfoHeadView?
    var footView: UIView?
    var textField: UITextField?
    var commentBtn: UIButton?
    var collectBtn: UIButton?
    var footshare: UIButton?
    var commentListArray:Array<NovelCommentModel> = []
    
    
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: VideoPlayerCustomView())
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        player.autoPlay()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default
            .addObserver(self,selector: #selector(keyboardWillHide(notification:)),
                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        self.navView = navView
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "gengduo"), for: .normal)
        self.navView?.addSubview(rightBtn)
        self.rightBtn = rightBtn
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorWithHexColorString("e6e6e6")
        self.navView?.addSubview(lineView)
        self.lineView = lineView
//        let videoView = UIView()
//        videoView.backgroundColor = .blue
//        self.view.addSubview(videoView)
//        self.videoView = videoView
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let tableView = UITableView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EpisodeCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        self.tableView = tableView
        if model?.mark == "3" {
            self.navView?.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(0)
            })
            self.rightBtn?.snp.makeConstraints({ (make) in
                make.right.bottom.equalToSuperview()
                make.width.height.equalTo(0)
            })
            self.lineView?.snp.makeConstraints({ (make) in
                make.right.bottom.equalToSuperview()
                make.width.height.equalTo(0)
            })
//            self.videoView?.snp.makeConstraints({ (make) in
//                make.left.right.top.equalToSuperview()
//                make.height.equalTo(videoView.snp.width).multipliedBy(9.0/16.0).priority(750)
//            })
            self.view?.addSubview(self.player)
            self.player.delegate = self
            self.player.setVideo(resource: BMPlayerResource(url: URL(string:model?.videourl ?? "")!))
            self.player.backBlock = { [unowned self] (isFullScreen) in
                if isFullScreen == true { return }
                let _ = self.navigationController?.popViewController(animated: true)
            }
            self.player.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
            self.tableView?.snp.makeConstraints({ (make) in
                make.top.equalTo(self.player.snp.bottom)
                make.left.right.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(-40)
            })
        }else{
            self.navView?.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(64)
            })
            self.rightBtn?.snp.makeConstraints({ (make) in
                make.right.bottom.equalToSuperview()
                make.width.height.equalTo(44)
            })
            self.lineView?.snp.makeConstraints({ (make) in
                make.right.bottom.left.equalToSuperview()
                make.height.equalTo(1)
            })
            self.tableView?.snp.makeConstraints({ (make) in
                make.top.equalTo(self.navView!.snp.bottom)
                make.left.right.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(-40)
            })
        }
        self.leftBtn?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(44)
        })
        let hView = EpisodeInfoHeadView()
        hView.model = self.model
        hView.setValue()
        self.hView = hView
        self.tableView?.tableHeaderView = self.hView
        self.hView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalTo(self.view)
        }
        
        let headerView = self.tableView?.tableHeaderView!
        headerView?.setNeedsLayout()
        // 立马布局子视图
        headerView?.layoutIfNeeded()
        let height = headerView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView?.frame
        frame?.size.height = height!
        headerView?.frame = frame!
        // 重新设置tableHeaderView
        tableView.tableHeaderView = headerView
        //将返回放到界面顶端
        self.view.bringSubview(toFront: self.leftBtn!)
        //footView
        let footView = UIView()
        footView.backgroundColor = .white
        self.view.addSubview(footView)
        self.footView = footView
        let line = UIView()
        line.backgroundColor = UIColor.colorWithHexColorString("e1e2e3")
        self.footView?.addSubview(line)
        let textField = UITextField()
        textField.placeholder = "写评论..."
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.colorWithHexColorString("e1e2e3").cgColor
        textField.layer.cornerRadius = 15
        textField.leftViewMode = UITextFieldViewMode.always
        textField.font = UIFont.systemFont(ofSize: 15)
        self.footView?.addSubview(textField)
        self.textField = textField
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "xiepinglun")
        self.textField?.leftView = imageView
        let commentBtn = UIButton(type: .custom)
        commentBtn.setImage(UIImage(named: "pinglun"), for: .normal)
        self.footView?.addSubview(commentBtn)
        self.commentBtn = commentBtn
        let collectBtn = UIButton(type: .custom)
        collectBtn.setImage(UIImage(named: "shoucang"), for: .normal)
        self.footView?.addSubview(collectBtn)
        self.collectBtn = collectBtn
        let footshare = UIButton(type: .custom)
        footshare.setImage(UIImage(named: "fenxiang"), for: .normal)
        self.footView?.addSubview(footshare)
        self.footshare = footshare
        self.footView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        })
        self.textField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.footView!).offset(20)
            make.centerY.equalTo(self.footView!)
            make.height.equalTo(30)
            make.width.equalTo(screenWidth/2-20)
        })
        self.commentBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.footView!)
            make.width.height.equalTo(40)
            make.right.equalTo(self.collectBtn!.snp.left).offset(-10)
        })
        self.collectBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.footView!)
            make.width.height.equalTo(40)
            make.right.equalTo(self.footshare!.snp.left).offset(-10)
        })
        self.footshare?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.footView!)
            make.width.height.equalTo(40)
            make.right.equalTo(self.footView!.snp.right).offset(-10)
        })
        requestComment()
        // Do any additional setup after loading the view.
    }
    func requestComment() {
        let keyChain = KeyChain()
        let fromId = keyChain.getKeyChain()["id"] ?? ""
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"typeId":self.model?.id ?? "","fromId":fromId]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: commentByType, parameters: parData) { (json) in
            if let datas = json["commentList"].arrayObject{
                self.commentListArray += datas.compactMap({NovelCommentModel.deserialize(from: $0 as? Dictionary)})
            }
            self.tableView?.reloadData()
        }
    }
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: false)
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let begin = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let end = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if begin.size.height > 0 && begin.origin.y-end.origin.y>0 {
                UIView.animate(withDuration: 0.1) {
                    self.footView?.frame = CGRect(x: 0, y: screenHeight - 50 - begin.height, width: screenWidth, height: 50)
                }
                self.view.layoutIfNeeded()
            }
            print("keyboardSize\(begin)")
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1) {
                self.footView?.frame = CGRect(x: 0, y: screenHeight - 50, width: screenWidth, height: 50)
            }
            self.view.layoutIfNeeded()
            print("keyboardSize\(keyboardSize)")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension EpisodeInfoViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeCommentTableViewCell
        cell.model = self.commentListArray[indexPath.row]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
// MARK:- BMPlayerDelegate example
extension EpisodeInfoViewController: BMPlayerDelegate {
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        player.snp.remakeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            if isFullscreen {
                make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(900)
                self.leftBtn?.isHidden = true
            } else {
                make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(900)
                self.leftBtn?.isHidden = false
            }
        }
        self.footView?.snp.remakeConstraints({ (make) in
            if isFullscreen {
                make.top.equalTo(self.view.snp.bottom).offset(100)
                print("1111111")
            } else {
                print("222222")
                make.left.right.bottom.equalTo(self.view)
                make.height.equalTo(40)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}
