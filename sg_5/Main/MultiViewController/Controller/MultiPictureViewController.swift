//
//  MultiPictureViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/31.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MultiPictureViewController: UIViewController {
    var scrollerView: UIScrollView?
    var contentView: UIView?
    var lastImageView: UIImageView?
    var imageURLArr: Array<String> = [String]()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let navView = UIView()
        navView.backgroundColor = .colorAccent
        self.view.addSubview(navView)
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        navView.addSubview(backBtn)
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.textAlignment = .center
        titleLab.textColor = .white
        navView.addSubview(titleLab)
        
        
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(navView)
            make.width.height.equalTo(44)
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(backBtn)
            make.width.equalTo(navView).offset(-88)
            make.centerX.equalTo(navView)
        }
        //[self setAutomaticallyAdjustsScrollViewInsets:NO];
        let scrollerView = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollerView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        scrollerView.isPagingEnabled = true
        scrollerView.bounces = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.alwaysBounceVertical = false
        self.view.addSubview(scrollerView)
        self.scrollerView = scrollerView
        let contentView = UIView()
        scrollerView.addSubview(contentView)
        self.contentView = contentView
        self.scrollerView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0))
        })
        for i in 0 ..< self.imageURLArr.count {
            let imageView: UIImageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true;
            imageView.kf.setImage(with: URL(string:"\(self.imageURLArr[i])"))
            imageView.isUserInteractionEnabled = true
            self.contentView?.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self.contentView!)
                make.width.equalTo(self.view)
                if lastImageView != nil {
                    make.left.equalTo(self.lastImageView!.snp.right)
                    
                }else{
                    make.left.equalTo(self.contentView!)
                }
            }
            self.lastImageView = imageView
        }
        self.contentView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.scrollerView!).inset(UIEdgeInsets.zero)
            make.height.equalTo(self.scrollerView!)
            make.right.equalTo(self.lastImageView!.snp.right)
        })
        self.view.layoutIfNeeded()
        
    }
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
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
