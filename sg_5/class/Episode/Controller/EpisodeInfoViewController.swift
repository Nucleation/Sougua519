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
    var videoView:UIView?
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
    var totolComment: UILabel?
    var totolUp: UILabel?
    var tableView: UITableView?
    var hView:EpisodeInfoHeadView?
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: VideoPlayerCustomView())
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        let videoView = UIView()
        videoView.backgroundColor = .blue
        self.view.addSubview(videoView)
        self.videoView?.addSubview(self.player)
        self.player.setVideo(resource: BMPlayerResource(url: URL(string:model?.videourl ?? "")!))
        
        self.videoView = videoView
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "fanhui"), for: .normal)
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
            self.videoView?.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(210)
            })
            self.player.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalToSuperview()
            }
            self.tableView?.snp.makeConstraints({ (make) in
                make.top.equalTo(self.videoView!.snp.bottom)
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
        // Do any additional setup after loading the view.
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return (cell)!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let totolComment = UILabel()
        totolComment.text = "评论 0"
        totolComment.font = UIFont.systemFont(ofSize: 14)
        totolComment.textColor = UIColor.colorWithHexColorString("666666")
        sectionView.addSubview(totolComment)
        let totolUp = UILabel()
        totolUp.text = "0 赞"
        totolUp.font = UIFont.systemFont(ofSize: 14)
        totolUp.textColor = UIColor.colorWithHexColorString("666666")
        sectionView.addSubview(totolUp)
        totolComment.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        totolUp.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        self.totolComment = totolComment
        self.totolUp = totolUp
        return sectionView
    }
}
