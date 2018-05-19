//
//  CategoryButtonView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/20.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol CategoryButtonViewDelegate {
    func categoryBtnClick(sender: UIButton)
}
class CategoryButtonView: UIView ,UIScrollViewDelegate{
    var delegate:CategoryButtonViewDelegate?
    var scrollView:UIScrollView?
    var pageControl: UIPageControl?
    let pItemWidth: CGFloat = 40
    let pHeight:CGFloat = 40
    var pageNumber: Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setSubViewWithButtonModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setSubViewWithButtonModel() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        self.addSubview(scrollView)
        self.scrollView = scrollView
        NetworkTool.loadHomePageCategoryButtonData { (categoryButtonList) in
            let buttonCount = categoryButtonList.count
            let pagesNumber:Int = buttonCount/11 + 1
            self.pageNumber = pagesNumber
            self.scrollView?.contentSize = CGSize(width: self.width * CGFloat(pagesNumber), height: self.height)
            for buttonModel in categoryButtonList {
                let buttonWidth = (self.scrollView?.width)!/5
                let buttonHeight = ((self.scrollView?.height)!-40)/2
                let buttonX = CGFloat(buttonModel.index%5) * buttonWidth + CGFloat(buttonModel.index/10) * (self.scrollView?.width)!
                let buttonY = CGFloat(buttonModel.index/5%2)*buttonHeight
                let button = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
                button.tag = buttonModel.index
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.black, for: UIControlState.normal)
                button.setTitle(buttonModel.title, for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14 )
                button.setImage(UIImage(named: buttonModel.imageurl), for: UIControlState.normal)
                button.addTarget(self, action: #selector(self.tapped(_: )), for: UIControlEvents.touchUpInside)
                //设置文字偏移：向下偏移图片高度＋向左偏移图片宽度 （偏移量是根据［图片］大小来的，这点是关键）
                button.titleEdgeInsets = UIEdgeInsets(top: button.imageView!.frame.size.height, left: -button.imageView!.frame.size.width, bottom: 0, right: 0)
                //设置图片偏移：向上偏移文字高度＋向右偏移文字宽度 （偏移量是根据［文字］大小来的，这点是关键）
                button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -button.titleLabel!.bounds.size.width)
                self.scrollView?.addSubview(button)
            }
        }
        let pageControl = UIPageControl(frame: CGRect(x: self.center.x - (self.pItemWidth * CGFloat(self.pageNumber!))/2, y: self.height-self.pHeight, width: self.pItemWidth * CGFloat(self.pageNumber!), height: self.pHeight))
        pageControl.currentPage = 0
        pageControl.numberOfPages = self.pageNumber!
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.brown
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.addTarget(self, action: #selector(self.clickPageControl(_:)), for: UIControlEvents.valueChanged)
        self.addSubview(pageControl)
        self.pageControl = pageControl
    }
    @objc func clickPageControl(_ sender: UIPageControl){
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        self.scrollView?.scrollRectToVisible(frame, animated:true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.width)
        self.pageControl?.currentPage = page
        
    }
    @objc private func tapped(_ button:UIButton){
       delegate?.categoryBtnClick(sender: button)
    }

}
