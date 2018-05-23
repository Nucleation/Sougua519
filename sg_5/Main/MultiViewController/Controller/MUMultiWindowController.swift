//
//  MUMultiWindowController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/16.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import WebKit

class MUMultiWindowController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseProductsData.count
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT - 150)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //unowned let self = self
        let cell = MUMutiWindowCollectionViewCell.cellWithCollectionViewWithIndexPath(collectionView: collectionView, indexPath: indexPath)
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MUMutiWindowCollectionViewCell
        //cell.multiWindow = baseProductsData[indexPath.item]
        cell.setMultiwindow(multiWindow: baseProductsData[indexPath.item])
        cell.MultiWindowBlock = { (sender: UIButton, multiWindow: MUMultiWindowModel) -> Void in
            if self.baseProductsData.count < 2 {
                UIApplication.shared.keyWindow?.rootViewController = MUNaigationViewController(rootViewController: MuRootViewController())
                return
            }
            self.deleteWindow(window: multiWindow.window!)
            self.baseProductsData.removeObject(object: multiWindow)
            self.collectionView?.performBatchUpdates({
                self.collectionView?.deleteItems(at: [indexPath])
            }, completion: { (finished) in
                self.collectionView?.reloadData()
            })

        }

        return cell
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            let translatedPoint = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: gestureRecognizer.view)
            if fabs(translatedPoint.x) > fabs(translatedPoint.y){
                return true
            }
        }
        return false
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let multiWindow = baseProductsData[indexPath.item]
        self.navigationController?.popViewController(animated: false)
        if (multiWindow.window?.isKeyWindow)! {
            return
        }
        UIApplication.shared.keyWindow?.resignKey()
        multiWindow.window?.makeKeyAndVisible()
    }
    
//    lazy var baseProductsData:[Any] = {
//        var baseData:Array<UIWindow> = []
//        let windows = UIApplication.shared.windows
//        for  eachWindow in windows {
//            //没有判断eachwindow isHidden
//            if eachWindow is MultiWindow{
//                self.addWindow(window: eachWindow)
//            }
//        }
//    }()
    //数据源
    var baseProductsData: Array = [MUMultiWindowModel]()
    var window: MultiWindow?
    //MARK: 添加collectionview flowlayout
    var cardLayout: MUmultiWindowFlowlayout?
    var collectionView: UICollectionView?
//    lazy var collectiomView: UICollectionView = {
//        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50))
//        collectionView.register(MUMutiWindowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        self.view.addSubview(collectionView)
//        return collectionView
//    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //从uiwindows中取出window
        let windows = UIApplication.shared.windows
        for  eachWindow in windows {
            //没有判断eachwindow isHidden
            if eachWindow is MultiWindow && !eachWindow.isHidden{
                self.addWindow(window: eachWindow)
            }
        }
        //初始化flowLayout
        cardLayout = MUmultiWindowFlowlayout(offsetY: 150)
        cardLayout?.delegate = self as? MUMultiWindowFlowlayoutDelegate
        //初始化collectionView
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-44), collectionViewLayout:cardLayout!)
        collectionView?.register(MUMutiWindowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        collectionView?.setContentOffset(CGPoint(x: 0, y: (collectionView?.contentSize.height)! - (collectionView?.frame.height)!), animated: false)
        //设置底部操作视图
        let oprateView = MUOprateView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 44, width: SCREEN_WIDTH, height: 44))
        oprateView.dataArray = ["window_add","window_back"]
        oprateView.OprateBlock = {sender in
            self.oprateClick(sender: sender)
        }
        oprateView.backgroundColor = UIColor.white
        self.view.addSubview(oprateView)
//        for  eachWindow in windows {
//            //没有判断eachwindow isHidden
//            if eachWindow is MultiWindow{
//                let nav = window?.rootViewController as! MUNaigationViewController
//                if nav.opendViewControllers.last is MUMultiWindowController {
//                    nav.opendViewControllers.removeLast()
//                }
//
//            }
//        }
        
        // Do any additional setup after loading the view.
    }
    //操作按钮代理方法
    func oprateClick(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.navigationController?.popViewController(animated: true)
            createWindow()
        case 2:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    //创建新的window
    func createWindow(){
        if (self.window != nil) {
            deleteWindow(window: self.window!)
        }
        UIApplication.shared.keyWindow?.resignKey()
        self.window = MultiWindow(frame: UIScreen.main.bounds)
        self.window?.windowLevel = UIWindowLevelNormal
        self.window?.rootViewController = MUNaigationViewController(rootViewController: MuRootViewController())
        self.window?.isHidden = false
        self.window?.makeKeyAndVisible()
    }
    //删除window
    func deleteWindow(window: UIWindow){
        (window.rootViewController as! MUNaigationViewController).opendViewControllers.removeAll()
        (window.rootViewController as! MUNaigationViewController).viewControllers = Array()
        window.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        window.rootViewController = nil
        window.resignKey()
        window.removeFromSuperview()
        window.isHidden = true
    }
    //降window加入数据源中
    func addWindow(window: UIWindow) {
        let nav = window.rootViewController as! MUNaigationViewController
        if nav.opendViewControllers.last is MUMultiWindowController {
            nav.opendViewControllers.removeLast()
        }
        var vc = nav.opendViewControllers.last
        if vc is MUMultiWindowController {
            vc = nav.viewControllers[nav.viewControllers.count]
        }
        var title:String = "首页"
        var icon:String = "net"
        if vc is MuRootViewController{
            title = "首页"
        }else if vc is HTMLViewController {
            title = (vc as! HTMLViewController).webTitle!
            icon = (vc as! HTMLViewController).str!
        }
        let img = captureView(viewController: vc!)
        let multiWindow = MUMultiWindowModel().initWithImageAndTitleAndIconAndwindow(image: img, title: title, icon: icon, window: window)
        self.baseProductsData.append(multiWindow)
    }
    //获取页面截图
    func captureView(viewController: UIViewController) -> (UIImage) {
        let originView = viewController.view
        let frame = viewController is HTMLViewController ? CGRect(x: 0, y: SCREEN_HEIGHT, width: (originView?.frame.width)!, height: (originView?.frame.height)! - 128):CGRect(x: 0, y: 0, width: (originView?.frame.width)!, height: (originView?.frame.height)! - 64)
        UIGraphicsBeginImageContext(frame.size)
        var img: UIImage?
        // *WKWebView截屏只显示背景，因此和其他方式截屏区分开（UIWebVIew正常）
        UIGraphicsEndImageContext()
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        viewController.view.layer.render(in: context!)
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
