//
//  RemakePwdViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/7.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class RemakePwdViewController: UIViewController {
    @IBOutlet weak var userMobileLab: UILabel!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var surePwdTF: UITextField!
    @IBOutlet weak var getCodeBtn: UIButton!
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            getCodeBtn.setTitle("\(newValue)秒后重新获取", for: .normal)
            if newValue <= 0 {
                getCodeBtn.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                remainingSeconds = 30
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            
            getCodeBtn.isEnabled = !newValue
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.userMobileLab.text = KeyChain().getKeyChain()["mobile"] ?? ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changePwdBtnClick(_ sender: Any) {
        guard self.newPwdTF.text == self.surePwdTF.text else {
            self.view.makeToast("两次输入密码不一致")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"mobile":self.userMobileLab.text!,"passwd":self.newPwdTF.text!,"securityCode":self.codeTF.text!,"oldPasswd":KeyChain().getKeyChain()["passwd"] ?? ""]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: resetPwdUrl, parameters: parData) { (json) in
            if json["code"] == "1" {
                self.view.makeToast("修改成功")
                KeyChain().savekeyChain(dic: ["mobile":json["mobile"].stringValue,"id":json["id"].stringValue,"token":json["token"].stringValue,"headUrl" : json["headUrl"].stringValue,"isLogin" : "1","passwd" : self.newPwdTF.text ?? ""])
            }
        }
    }
    @IBAction func getCodeClick(_ sender: Any) {
        let urlStr = ucenterGetSecurityCode
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["mobile":self.userMobileLab.text ?? "","timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (result) in
            print(result)
        }
        isCounting = true
    }
    @objc func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    @IBAction func leftBtnClick(_ sender: Any) {
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
