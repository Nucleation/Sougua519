//
//  PCTableViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class PCTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var subLab: UIButton!
    
    @IBOutlet var mainTab: UITableView!

    @IBOutlet weak var userIcon: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        //判断用户登录
        if KeyChain().getKeyChain()["isLogin"] != "1" {
            self.userIcon.setImage(UIImage(named: "userIMG.jpg"), for: .normal)
        }else{
            self.userIcon.kf.setImage(with: URL(string: "\(postUrl)/images/\( KeyChain().getKeyChain()["headUrl"] ?? "")"), for: .normal)
            self.userName.setTitle("\(KeyChain().getKeyChain()["mobile"] ?? "")", for: .normal)
            self.subLab.isHidden = true
        }
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

    @IBAction func userNameClick(_ sender: Any) {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

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
