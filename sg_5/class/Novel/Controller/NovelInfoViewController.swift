//
//  NovelInfoViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/18.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelInfoViewController: UIViewController {
    var novelInfo: NoveCategoryListModel?    
    var tableView: UITableView?
    lazy var commentArr: Array = [NovelCommentModel]()
    var headView: UIView?
    var bookView:UIView?
    var novelImageView: UIImageView?
    var novelTitleLab: UILabel?
    var novelAuthorLab: UILabel?
    var novelCategoryLab: UILabel?
    var novelWordCountLab: UILabel?
    var novelCreatTimeLab: UILabel?
    var joinBookshelfBtn: UIButton?
    var beginReadBtn: UIButton?
    var briefLab: UILabel?
    var lineView: UIView?
    var commentView: UIView?
    var vView: UIView?
    var bookCommentLab: UILabel?
    var moreBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        createUI()
        getComment()
        //addComment()
        // Do any additional setup after loading the view.
    }
    func setNav(){
       
    }
    func createUI(){
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), style: .plain)
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"NovelCommentTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"novelCommentCell")
        self.view.addSubview(tableView)
        self.tableView = tableView
        let headView = UIView()
        headView.backgroundColor = UIColor.lightGray
        self.headView = headView
        self.headView?.frame.size.height = (self.headView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)!
        tableView.tableHeaderView = self.headView
        let bookView = UIView()
        bookView.backgroundColor = .white
        headView.addSubview(bookView)
        self.bookView = bookView
        let novelImageView = UIImageView()
        novelImageView.backgroundColor = . green
        novelImageView.kf.setImage(with: URL(string: self.novelInfo?.fictionImg ?? ""))
        novelImageView.layer.cornerRadius = 5
        bookView.addSubview(novelImageView)
        self.novelImageView = novelImageView
        let novelTitleLab = UILabel()
        novelTitleLab.text = self.novelInfo?.fictionName ?? ""
        bookView.addSubview(novelTitleLab)
        self.novelTitleLab = novelTitleLab
        let novelAuthorLab = UILabel()
        novelAuthorLab.text = "作者:\(self.novelInfo?.fictionAuthor ?? "")"
        novelTitleLab.font = UIFont.systemFont(ofSize: 11)
        bookView.addSubview(novelAuthorLab)
        self.novelAuthorLab = novelAuthorLab
        let novelCategoryLab = UILabel()
        novelCategoryLab.text = "分类:\(self.novelInfo?.categoryName ?? "")"
        novelCategoryLab.font = UIFont.systemFont(ofSize: 11)
        bookView.addSubview(novelCategoryLab)
        self.novelCategoryLab = novelCategoryLab
        let novelWordCountLab = UILabel()
        novelWordCountLab.text = "字数:\(self.novelInfo?.fictionWordCount ?? "")"
        novelWordCountLab.font = UIFont.systemFont(ofSize: 11)
        bookView.addSubview(novelWordCountLab)
        self.novelWordCountLab = novelWordCountLab
        let novelCreatTimeLab = UILabel()
        novelCreatTimeLab.text = "创建时间:\(self.novelInfo?.createTime ?? "")"
        novelCreatTimeLab.font = UIFont.systemFont(ofSize: 11)
        novelCreatTimeLab.textColor = UIColor.colorWithHexColorString("8b8b8b")
        bookView.addSubview(novelCreatTimeLab)
        self.novelCreatTimeLab = novelCreatTimeLab
//        var beginReadBtn: UIButton?
//        var briefLab: UILabel?
        let joinBookshelfBtn = UIButton(type: .custom)
        joinBookshelfBtn.backgroundColor = .blue
        joinBookshelfBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        joinBookshelfBtn.setTitle("加入书架", for: UIControlState.normal)
        joinBookshelfBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 )
        joinBookshelfBtn.setImage(UIImage(named: "add"), for: UIControlState.normal)
        joinBookshelfBtn.layer.cornerRadius = 5
        bookView.addSubview(joinBookshelfBtn)
        self.joinBookshelfBtn = joinBookshelfBtn
        let beginReadBtn = UIButton(type: .custom)
        beginReadBtn.backgroundColor = .blue
        beginReadBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        beginReadBtn.setTitle("开始阅读", for: UIControlState.normal)
        beginReadBtn.addTarget(self, action: #selector(beginReadBtnClick), for: .touchUpInside)
        beginReadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 )
        beginReadBtn.setImage(UIImage(named: "sousuo"), for: UIControlState.normal)
        beginReadBtn.layer.cornerRadius = 5
        bookView.addSubview(beginReadBtn)
        self.beginReadBtn = beginReadBtn
        let lineView = UIView()
        lineView.backgroundColor = .gray
        bookView.addSubview(lineView)
        self.lineView = lineView
        let briefLab = UILabel()
        briefLab.textColor = .black
        briefLab.numberOfLines = 6
        briefLab.text = self.novelInfo?.fictionBrief.trimmingCharacters(in: NSCharacterSet.newlines)
        bookView.addSubview(briefLab)
        self.briefLab = briefLab
        let commentView = UIView()
        commentView.backgroundColor = UIColor.white
        headView.addSubview(commentView)
        self.commentView = commentView
        let vView = UIView()
        vView.backgroundColor = UIColor.blue
        self.commentView?.addSubview(vView)
        self.vView = vView
        let bookCommentLab = UILabel()
        bookCommentLab.text = "热门评论"
        bookCommentLab.font = UIFont.systemFont(ofSize: 14)
        self.commentView?.addSubview(bookCommentLab)
        self.bookCommentLab = bookCommentLab
        let moreBtn = UIButton(type: .custom)
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.setTitleColor(UIColor.black, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.commentView?.addSubview(moreBtn)
        self.moreBtn = moreBtn
//        self.tableView?.snp.makeConstraints({ (make) in
//            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0))
//        })
        self.headView?.snp.makeConstraints({ (make) in
            make.edges.equalTo((self.tableView?.tableHeaderView)!).inset(UIEdgeInsets.zero)
            make.width.equalTo(screenWidth)
        })
        self.bookView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.headView!)
        })
        self.novelImageView?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self.bookView!).offset(30)
            make.width.equalTo(90)
            make.height.equalTo(120)
        })
        self.novelTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.novelImageView!).offset(5)
            make.left.equalTo(self.novelImageView!.snp.right).offset(17)
            make.height.equalTo(34)
        })
        self.novelAuthorLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.novelTitleLab!)
            make.height.equalTo(25)
            make.top.equalTo(self.novelTitleLab!.snp.bottom)
        })
        self.novelCategoryLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.novelTitleLab!)
            make.height.equalTo(25)
            make.top.equalTo(self.novelAuthorLab!.snp.bottom)
        })
        self.novelWordCountLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.novelTitleLab!)
            make.height.equalTo(25)
            make.top.equalTo(self.novelCategoryLab!.snp.bottom)
        })
        self.novelCreatTimeLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.novelTitleLab!)
            make.height.equalTo(25)
            make.top.equalTo(self.novelWordCountLab!.snp.bottom)
        })
        self.joinBookshelfBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.novelImageView!)
            make.height.equalTo(36)
            make.width.equalTo(115)
            make.top.equalTo(self.novelImageView!.snp.bottom).offset(30)
        })
        self.beginReadBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.joinBookshelfBtn!.snp.right).offset(13)
            make.height.width.equalTo(self.joinBookshelfBtn!)
            make.top.equalTo(self.joinBookshelfBtn!)
        })
        self.lineView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.joinBookshelfBtn!.snp.bottom).offset(20)
            make.width.equalTo(self.bookView!).offset(-40)
            make.left.equalTo(self.bookView!).offset(20)
            make.height.equalTo(1)
        })
        self.briefLab?.snp.makeConstraints({ (make) in
            make.width.centerX.equalTo(self.lineView!)
            make.top.equalTo(self.lineView!.snp.bottom)
            make.bottom.equalTo(self.bookView!)
        })
        self.commentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.headView!)
            make.top.equalTo(self.bookView!.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.bottom.equalTo(self.headView!)
        })
        self.vView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.commentView!).offset(20)
            make.width.equalTo(3)
            make.height.equalTo(15)
            make.centerY.equalTo(self.commentView!)
        })
        self.bookCommentLab?.snp.makeConstraints({ (make) in
            make.centerY.height.equalTo(self.commentView!)
            make.left.equalTo(self.vView!).offset(10)
        })
        self.moreBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.commentView!).offset(-20)
            make.centerY.height.equalTo(self.commentView!)
        })
    }
    @objc func beginReadBtnClick() {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"id":self.novelInfo?.id ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
            let vc = NovelContentViewController()
            vc.content = json["content"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getComment(){
        let keyChain = KeyChain()
        let fromId = keyChain.getKeyChain()["id"] ?? ""
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"typeId":self.novelInfo?.id ?? "","fromId":fromId]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: commentByType, parameters: parData) { (json) in
            let resJson = json["commentList"].array
            for item in resJson! {
                let model = NovelCommentModel()
                if let fromId = item["fromId"].string{
                    model.fromId = fromId
                }
                if let typeId = item["typeId"].string{
                    model.typeId = typeId
                }
                if let content = item["content"].string{
                    model.content = content
                }
                if let id = item["id"].string{
                    model.id = id
                }
                if let createDate = item["createDate"].string{
                    model.createDate = createDate
                }
                if let type = item["type"].string{
                    model.type = type
                }
                if let upCount = item["upCount"].string{
                    model.upCount = upCount
                }
                self.commentArr += [model]
            }
            self.tableView?.reloadData()
        }
    }
    func addComment() {
        let keyChain = KeyChain()
        guard let mobile = keyChain.getKeyChain()["mobile"],let token = keyChain.getKeyChain()["token"],let id = keyChain.getKeyChain()["id"] else {
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"typeId":self.novelInfo?.id ?? "","mobile":mobile,"token":token,"fromId":id,"type":"7","content":"测试添加评论"]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: addCommentUrl, parameters: parData) { (json) in
           print("\(json)--add")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension NovelInfoViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.commentArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "novelCommentCell") as! NovelCommentTableViewCell
        cell.comment = self.commentArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
