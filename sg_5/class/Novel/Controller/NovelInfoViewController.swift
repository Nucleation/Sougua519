//
//  NovelInfoViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/18.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelInfoViewController: UIViewController,CommentViewDelegate{
    
    
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
    var isJoinShelf: Bool = false
    var commentTVView: CommentView?
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default
            .addObserver(self,selector: #selector(keyboardWillHide(notification:)),
                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        getCheck()
        getComment()
        self.createUI()
        //addComment()
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let begin = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let end = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if begin.size.height > 0 && begin.origin.y-end.origin.y>0 {
                UIView.animate(withDuration: 0.1) {
                    self.commentTVView?.frame = CGRect(x: 0, y: screenHeight - 50 - begin.height, width: screenWidth, height: 50)
                }
                self.view.layoutIfNeeded()
               
                
            }
            print("keyboardSize\(begin)")
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1) {
                self.commentTVView?.frame = CGRect(x: 0, y: screenHeight - 50, width: screenWidth, height: 50)
            }
             self.view.layoutIfNeeded()
            print("keyboardSize\(keyboardSize)")
        }
    }
    func getCheck(){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"fictionId":self.novelInfo?.id ?? "","userId":KeyChain().getKeyChain()["id"] ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: checkNovelShelfUrl, parameters: parData) { (json) in
            self.isJoinShelf = json.boolValue
            if !self.isJoinShelf {
                self.joinBookshelfBtn?.setTitle("加入书架", for: UIControlState.normal)
                self.joinBookshelfBtn?.backgroundColor = .colorAccent
                
            }else{
                self.joinBookshelfBtn?.setTitle("已在书架", for: UIControlState.normal)
                self.joinBookshelfBtn?.backgroundColor = UIColor.colorWithHexColorString("b8b8b8")
                self.joinBookshelfBtn?.isUserInteractionEnabled = false
            }
        }
    }
    
    func createUI(){
        let navView = UIView()
        navView.backgroundColor = .white
        self.view.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(navView)
            make.width.height.equalTo(44)
        }
        
        let tableView = UITableView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"NovelCommentTableViewCell", bundle:nil),
                                forCellReuseIdentifier:"novelCommentCell")
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.height.equalTo(screenHeight-64-50)
        })
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        let headView = UIView()
        headView.backgroundColor = UIColor.lightGray
        
        let bookView = UIView()
        bookView.backgroundColor = .white
        headView.addSubview(bookView)
        self.bookView = bookView
        let novelImageView = UIImageView()
        novelImageView.kf.setImage(with: URL(string: self.novelInfo?.fictionImg ?? ""))
        novelImageView.layer.cornerRadius = 5
        bookView.addSubview(novelImageView)
        self.novelImageView = novelImageView
        let novelTitleLab = UILabel()
        novelTitleLab.font = UIFont.systemFont(ofSize: 17)
        novelTitleLab.textColor = .colorAccent
        novelTitleLab.text = self.novelInfo?.fictionName ?? ""
        bookView.addSubview(novelTitleLab)
        self.novelTitleLab = novelTitleLab
        let novelAuthorLab = UILabel()
        novelAuthorLab.text = "作者:\(self.novelInfo?.fictionAuthor ?? "")"
        novelAuthorLab.font = UIFont.systemFont(ofSize: 14)
        novelAuthorLab.textColor = UIColor.colortext2
        bookView.addSubview(novelAuthorLab)
        self.novelAuthorLab = novelAuthorLab
        let novelCategoryLab = UILabel()
        novelCategoryLab.text = "分类:\(self.novelInfo?.categoryName ?? "")"
        novelCategoryLab.font = UIFont.systemFont(ofSize: 14)
        novelCategoryLab.textColor = UIColor.colortext2
        bookView.addSubview(novelCategoryLab)
        self.novelCategoryLab = novelCategoryLab
        let novelWordCountLab = UILabel()
        novelWordCountLab.text = "字数:\(self.novelInfo?.fictionWordCount ?? "")"
        novelWordCountLab.font = UIFont.systemFont(ofSize: 14)
        novelWordCountLab.textColor = UIColor.colortext2
        bookView.addSubview(novelWordCountLab)
        self.novelWordCountLab = novelWordCountLab
        let novelCreatTimeLab = UILabel()
        novelCreatTimeLab.text = "创建时间:\(self.novelInfo?.createTime ?? "")"
        novelCreatTimeLab.font = UIFont.systemFont(ofSize: 14)
        novelCreatTimeLab.textColor = UIColor.colortext2
        bookView.addSubview(novelCreatTimeLab)
        self.novelCreatTimeLab = novelCreatTimeLab
        let joinBookshelfBtn = UIButton(type: .custom)
        
        joinBookshelfBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        if !self.isJoinShelf {
            joinBookshelfBtn.setTitle("加入书架", for: UIControlState.normal)
            joinBookshelfBtn.backgroundColor = .colorAccent
            
        }else{
            joinBookshelfBtn.setTitle("已在书架", for: UIControlState.normal)
            joinBookshelfBtn.backgroundColor = UIColor.colorWithHexColorString("b8b8b8")
            joinBookshelfBtn.isUserInteractionEnabled = false
        }
        
        joinBookshelfBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 )
        joinBookshelfBtn.setImage(UIImage(named: "add"), for: UIControlState.normal)
        joinBookshelfBtn.addTarget(self, action: #selector(joinBookshelfBtnClick), for: .touchUpInside)
        joinBookshelfBtn.layer.cornerRadius = 5
        bookView.addSubview(joinBookshelfBtn)
        self.joinBookshelfBtn = joinBookshelfBtn
        let beginReadBtn = UIButton(type: .custom)
        beginReadBtn.backgroundColor = .colorAccent
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
        briefLab.textColor = .colortext2
        briefLab.font = UIFont.systemFont(ofSize: 15)
        briefLab.numberOfLines = 6
        briefLab.text = self.novelInfo?.fictionBrief.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
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
        let commentTVView = CommentView(frame: CGRect(x: 0, y: screenHeight - 50, width: screenWidth, height: 50))
        commentTVView.delegate = self
        commentTVView.novelInfo = self.novelInfo
        self.view.addSubview(commentTVView)
        self.commentTVView = commentTVView
        
        self.bookView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(headView)
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
            make.left.right.equalTo(headView)
            make.top.equalTo(self.bookView!.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.bottom.equalTo(headView)
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
        self.headView = headView
        
        if #available(iOS 6.0, *) {
            self.headView?.frame.size.height = (self.headView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)!
        } else {
            self.headView?.frame.size = (self.headView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriority.defaultLow, verticalFittingPriority: UILayoutPriority.defaultLow))!
        }
        self.tableView?.tableHeaderView = self.headView
        
    }
    
    @objc func joinBookshelfBtnClick() {
        if KeyChain().getKeyChain()["mobile"]! == ""{
            self.view.makeToast("您还没有登录")
             return
        }else if self.isJoinShelf{
            return
        }else{
            let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
            let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"fictionId":self.novelInfo?.id ?? "","userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!,"mobile":KeyChain().getKeyChain()["mobile"]!]
            let parData = dic.toParameterDic()
            print(parData)
            NetworkTool.requestData(.post, URLString: addNovelShelfUrl, parameters: parData) { (json) in
                //添加书架后处理
                self.isJoinShelf = true
                self.joinBookshelfBtn?.setTitle("已在书架", for: UIControlState.normal)
                self.joinBookshelfBtn?.backgroundColor = UIColor.colorWithHexColorString("b8b8b8")
            }
        }
    }
    @objc func beginReadBtnClick() {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"id":self.novelInfo?.id ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelContent, parameters: parData) { (json) in
            let vc = NovelContentViewController()
            let model = NovelContentModel.deserialize(from: json.dictionaryObject)
            vc.novelContentModel = model
            vc.novelInfo = self.novelInfo
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func reloadComment() {
        getComment()
    }
    func getComment(){
        self.commentArr = []
        let keyChain = KeyChain()
        let fromId = keyChain.getKeyChain()["id"] ?? ""
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"typeId":self.novelInfo?.id ?? "","fromId":fromId]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: commentByType, parameters: parData) { (json) in
            guard let resJson = json["commentList"].array else{
                return
            }
            for item in resJson {
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
extension NovelInfoViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.commentArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "novelCommentCell") as! NovelCommentTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.comment = self.commentArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            self.view.endEditing(true)
        }
        
    }
}
