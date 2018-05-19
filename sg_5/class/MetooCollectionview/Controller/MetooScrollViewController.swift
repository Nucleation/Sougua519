//
//  MetooScrollViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/19.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class MetooScrollViewController: UIViewController {
    var scrollerView: UIScrollView?
    var contentView: UIView?
    
    var pictureModelArr: Array<PictureClassifyModel> = []
    var lastImageView: UIImageView?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollerView = UIScrollView()
        scrollerView.isPagingEnabled = true
        scrollerView.bounces = false
        self.view.addSubview(scrollerView)
        self.scrollerView = scrollerView
        let contentView = UIView()
        scrollerView.addSubview(contentView)
        self.contentView = contentView
        self.scrollerView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.zero)
        })   
        for i in 0 ..< pictureModelArr.count {
            let imageView: UIImageView = UIImageView()
            //imageView.contentMode = .scaleAspectFit
            imageView.kf.setImage(with: URL(string:"\(pictureModelArr[i].downloadUrl)"))
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
