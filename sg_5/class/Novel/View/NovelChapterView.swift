//
//  NovelChapterView.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/29.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol NovelChapterViewDelegate {
    func reloadNovel(model:NovelChapterModel)
    func changeIndex(index: Int)
}
class NovelChapterView: UIView ,UITableViewDelegate,UITableViewDataSource{
    var tableView: UITableView?
    var novelChapterArray: Array<NovelChapterModel> = [NovelChapterModel]()
    var id: String?
    var delegate: NovelChapterViewDelegate?
    
    init(frame: CGRect,novelInfo: NoveCategoryListModel) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.requestData(novelInfo: novelInfo)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func requestData(novelInfo: NoveCategoryListModel) {
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":novelInfo.id]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: getNovelSection, parameters: parData) { (json) in
            self.novelChapterArray.removeAll()
            if let datas = json["sectionList"].arrayObject{
                self.novelChapterArray += datas.compactMap({NovelChapterModel.deserialize(from: $0 as? Dictionary)})
            }
           self.makeUI(novelInfo: novelInfo)
        }
    }
    func makeUI(novelInfo: NoveCategoryListModel) {
        let navView = UIView()
        navView.backgroundColor = .white
        self.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        let titleLab = UILabel()
        titleLab.textColor = .colorAccent
        titleLab.text = "目录"
        titleLab.textAlignment = .center
        titleLab.font = UIFont.systemFont(ofSize: 18)
        navView.addSubview(titleLab)
        let tableView = UITableView(frame: CGRect(x: 0, y: 68, width: screenWidth, height: screenHeight - 68), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 80))
        tableView.tableHeaderView = headview
        let footView = UIView()
        tableView.tableFooterView = footView
        
        let novelTitleLab = UILabel()
        novelTitleLab.text = novelInfo.fictionName
        novelTitleLab.font = UIFont.systemFont(ofSize: 16)
        novelTitleLab.textAlignment = .center
        headview.addSubview(novelTitleLab)
        
        let authorLab = UILabel()
        authorLab.textColor = .colortext1
        authorLab.text = novelInfo.fictionAuthor
        authorLab.font = UIFont.systemFont(ofSize: 14)
        authorLab.textAlignment = .center
        headview.addSubview(authorLab)
        
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(64)
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(navView)
            make.width.height.equalTo(44)
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn)
            make.centerX.equalTo(navView)
            make.height.equalTo(backBtn)
            make.width.equalTo(navView).offset(-88)
        }
        novelTitleLab.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(headview)
            make.centerY.equalTo(headview).offset(-10)
            make.height.equalTo(20)
        }
        authorLab.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(headview)
            make.centerY.equalTo(headview).offset(10)
            make.height.equalTo(20)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.novelChapterArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell (style: .default, reuseIdentifier: "cell")
            
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.text = self.novelChapterArray[indexPath.row].sectionName
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            delegate?.reloadNovel(model: self.novelChapterArray[indexPath.row])
            delegate?.changeIndex(index: indexPath.row + 1)
            self.removeFromSuperview()
        }
    }
    
    @objc func backBtnClick() {
        self.removeFromSuperview()
    }
}
