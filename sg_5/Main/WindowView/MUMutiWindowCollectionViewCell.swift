//
//  MUMutiWindowCollectionViewCell.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/17.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MUMutiWindowCollectionViewCell: UICollectionViewCell {
    //数据源
    var multiWindow:MUMultiWindowModel?
    //点击回调
    var MultiWindowBlock:(UIButton,MUMultiWindowModel) -> Void = { _,_ in  }
    //标题
    var titleButton: UIButton!
    //删除按钮
    var deleteButton: UIButton!
    //分割线
    var lineView: UIView!
    //背景图
    var imageView: UIImageView!
    
    //快速创建cell
    static func cellWithCollectionViewWithIndexPath(collectionView: UICollectionView,indexPath: IndexPath) -> (MUMutiWindowCollectionViewCell){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MUMutiWindowCollectionViewCell
        return cell
    }
    //重写initframe方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.createSubViews()
        
    }
    //swift重写init必须实现以下代码
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //创建子控件
    func createSubViews() {
        titleButton = UIButton(type: UIButtonType.custom)
        titleButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.addSubview(titleButton)
        deleteButton = UIButton(type: UIButtonType.custom)
        deleteButton.setImage(UIImage(named: "window_delete"), for: UIControlState.normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(deleteButton)
        lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        self.addSubview(lineView)
        imageView = UIImageView(image: UIImage(named: "baidu"))
        self.addSubview(imageView)
        
    }
    @objc func deleteButtonClick(sender: UIButton){
        self.MultiWindowBlock(sender, self.multiWindow!)
    }
    func setMultiwindow(multiWindow:MUMultiWindowModel) {
        self.multiWindow = multiWindow
        addData()
        addLayout()
    }
    //赋值
    func addData() {
        titleButton.setTitle((self.multiWindow?.title?.lengthOfBytes(using: String.Encoding.utf8) != 0) ? (self.multiWindow?.title) : "首页", for: UIControlState.normal)
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        imageView.image = self.multiWindow?.image
    }
    //布局
    func addLayout() {
        deleteButton.snp.makeConstraints { (make)-> Void in
            make.top.right.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        titleButton.snp.makeConstraints { (make) ->Void in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(deleteButton).offset(30)
            make.height.equalTo(40)
        }
        lineView.snp.makeConstraints { (make)->Void in
            make.left.right.equalTo(self)
            make.top.equalTo(titleButton.snp.bottom)
            make.height.equalTo(1)
        }
        imageView.snp.makeConstraints { (make)->Void in
            make.top.equalTo(lineView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
}
