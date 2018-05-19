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
    var scrollerView: UIScrollView?
    var contentView: UIView?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        createUI()
        // Do any additional setup after loading the view.
    }
    func setNav(){
        
    }
    func createUI(){
        let scrollerView = UIScrollView()
        scrollerView.backgroundColor = .gray
        //scrollerView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollerView)
        self.scrollerView = scrollerView
        let contentView = UIView()
        scrollerView.addSubview(contentView)
        self.contentView = contentView
        let bookView = UIView()
        bookView.backgroundColor = .white
        contentView.addSubview(bookView)
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
        bookView.addSubview(novelAuthorLab)
        self.novelAuthorLab = novelAuthorLab
        let novelCategoryLab = UILabel()
        novelCategoryLab.text = "分类:\(self.novelInfo?.categoryName ?? "")"
        bookView.addSubview(novelCategoryLab)
        self.novelCategoryLab = novelCategoryLab
        let novelWordCountLab = UILabel()
        novelWordCountLab.text = "字数:\(self.novelInfo?.fictionWordCount ?? "")"
        bookView.addSubview(novelWordCountLab)
        self.novelWordCountLab = novelWordCountLab
        let novelCreatTimeLab = UILabel()
        novelCreatTimeLab.text = "创建时间:\(self.novelInfo?.createTime ?? "")"
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
        contentView.addSubview(commentView)
        self.commentView = commentView
        
        self.scrollerView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.zero)
        })
        self.contentView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.scrollerView!).inset(UIEdgeInsets.zero)
            make.width.equalTo(self.scrollerView!)
        })
        self.bookView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.contentView!)
        })
        self.novelImageView?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self.bookView!).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(130)
        })
        self.novelTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.novelImageView!).offset(5)
            make.left.equalTo(self.novelImageView!.snp.right).offset(5)
            make.height.equalTo(30)
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
            make.height.equalTo(50)
            make.width.equalTo((self.view.width - 60)/2)
            make.top.equalTo(self.novelImageView!.snp.bottom).offset(5)
        })
        self.beginReadBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.bookView!).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo((self.view.width - 60)/2)
            make.top.equalTo(self.joinBookshelfBtn!)
        })
        self.lineView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.joinBookshelfBtn!.snp.bottom).offset(20)
            make.width.equalTo(self.bookView!).offset(-40)
            make.centerX.equalTo(self.bookView!)
            make.height.equalTo(1)
        })
        self.briefLab?.snp.makeConstraints({ (make) in
            make.width.centerX.equalTo(self.lineView!)
            make.top.equalTo(self.lineView!.snp.bottom)
            make.bottom.equalTo(self.bookView!)
        })
        self.commentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.bookView!.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.bottom.equalTo(self.contentView!)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
