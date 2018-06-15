//
//  PCTableViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import Kingfisher

class PCTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var subLab: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    @IBOutlet weak var cacheLab: UILabel!
    @IBOutlet var mainTab: UITableView!

    @IBOutlet weak var userIcon: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        //判断用户登录
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            self.logOutBtn.isHidden = true
            self.userIcon.setImage(UIImage(named: "userIMG"), for: .normal)
        }else{
            self.logOutBtn.isHidden = false
            if KeyChain().getKeyChain()["headUrl"] == ""{
                self.userIcon.setImage(UIImage(named: "userIMG"), for: .normal)
            }else{
                self.userIcon.kf.setImage(with: URL(string: "\(postUrl)/images/\( KeyChain().getKeyChain()["headUrl"] ?? "")"), for: .normal)
            }
            var mobile = KeyChain().getKeyChain()["mobile"]
            let reg = mobile?.toRange(NSMakeRange(3, 4))
            mobile = mobile?.replacingCharacters(in: reg!, with: "****")
            self.userName.setTitle(mobile, for: .normal)
            self.subLab.isHidden = true
        }
        self.cacheLab.text =  Xcache.returnCacheSize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
var picker:UIImagePickerController!
    @IBAction func userIconClick(_ sender: Any) {
        //判断用户登录
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            self.view.makeToast("未登录")
        }else{
            //判断设置是否支持图片库
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(picker, animated: true, completion: nil)
            }else{
                self.view.makeToast("读取相册错误")
            }
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.userIcon.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
        self.uploadImage(image: (info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        picker.dismiss(animated: true, completion: nil)
        
    }
    func uploadImage(image: UIImage){
        var imageData = UIImageJPEGRepresentation(image, 0.4)?.base64EncodedString()
        if imageData == nil {
            imageData = UIImagePNGRepresentation(image)?.base64EncodedString()
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"userId":KeyChain().getKeyChain()["id"]!,"token":KeyChain().getKeyChain()["token"]!,"headImg":imageData ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: UpHeadImageUrl, parameters: parData ) { (json) in
            KeyChain().setKeyChain(value: json.stringValue, forKey: "headUrl")
            //KeyChain().setKeyChain(value: json.stringValue, forKey: "headUrl")
            self.userIcon.kf.setImage(with: URL(string: "\(postUrl)/images/\( KeyChain().getKeyChain()["headUrl"] ?? "")"), for: .normal)
            self.view.makeToast("上传成功")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutClick(_ sender: Any) {
        KeyChain().clearkeyChain()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func userNameClick(_ sender: Any) {
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.view.makeToast("已登录")
        }
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 4{
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "您确定要清理缓存吗？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                Xcache.cleanCache {
                    self.cacheLab.text = Xcache.returnCacheSize()
                    self.view.makeToast("清理完成")
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
//        switch indexPath.row {
//        case 1:
//            let vc = markAndCollectionViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        case 2:
//            let vc = PCCollectionViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        case 3:
//            let vc = AboutUSViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        case 4:
//            Xcache.cleanCache {
//                self.cacheLab.text = Xcache.returnCacheSize()
//                self.view.makeToast("清理完成")
//            }
//        case 5:
//            let vc = SettingViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        default:
//            return
//        }
        
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 6 {
//            return 60
//        }else if indexPath.row == 0{
//            return 40
//        }else{
//            return 50
//        }
//    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
