//
//  LoginViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/5/10.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var logoImageView: UIImageView!
    var userNameTF: UITextField!
    var unLeftView: UIImageView!
    var passWordTF: UITextField!
    var pwLeftView: UIImageView!
    var loginBtn: UIButton!
    var firstLine: UIImageView?
    var secondLine: UIImageView?
    var findPwdBtn:UIButton?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createUI()
    }
    func createUI(){
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitleColor(.black, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.setTitle("注册", for: .normal)
        rightBtn.setTitleColor(.black, for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        self.view.addSubview(rightBtn)
        self.rightBtn = rightBtn
        let logoImageView = UIImageView(image: UIImage(named: "userIcon"))
        self.view.addSubview(logoImageView)
        self.logoImageView = logoImageView
        let userNameTF = UITextField()
        userNameTF.placeholder = "手机号"
        userNameTF.leftViewMode = UITextFieldViewMode.always
        let unLeftView = UIImageView(image: UIImage(named: "user"))
        unLeftView.frame = CGRect(x: 18, y: 0, width: 60, height: 50)
        unLeftView.contentMode = UIViewContentMode.center
        self.unLeftView = unLeftView
        userNameTF.leftView = unLeftView
        self.view.addSubview(userNameTF)
        self.userNameTF = userNameTF
        let passWordTF = UITextField()
        passWordTF.placeholder = "密码"
        passWordTF.isSecureTextEntry = true
        let pwLeftView = UIImageView(image: UIImage(named: "pwdImage"))
        passWordTF.leftViewMode = UITextFieldViewMode.always
        pwLeftView.frame = CGRect(x: 18, y: 0, width: 60, height: 50)
        pwLeftView.contentMode = UIViewContentMode.center
        self.pwLeftView = pwLeftView
        passWordTF.leftView = pwLeftView
        self.view.addSubview(passWordTF)
        self.passWordTF = passWordTF
        let loginBtn = UIButton(type: .custom)
        loginBtn.layer.cornerRadius = 25
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = .colorAccent
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        loginBtn.tag = 0
        self.view.addSubview(loginBtn)
        self.loginBtn = loginBtn
        let firstLine = UIImageView()
        firstLine.backgroundColor = UIColor.colorWithHexColorString("eeeeee")
        self.view.addSubview(firstLine)
        self.firstLine = firstLine
        let secondLine = UIImageView()
        secondLine.backgroundColor = UIColor.colorWithHexColorString("eeeeee")
        self.view.addSubview(secondLine)
        self.secondLine = secondLine
        let findPwdBtn = UIButton(type: .custom)
        findPwdBtn.titleLabel?.textAlignment = .center
        findPwdBtn.setTitle("忘记密码>>", for: .normal)
        findPwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        findPwdBtn.addTarget(self, action: #selector(findPwdBtnClick), for: .touchUpInside)
        findPwdBtn.setTitleColor(.colorAccent, for: .normal)
        self.view.addSubview(findPwdBtn)
        self.findPwdBtn = findPwdBtn
        self.leftBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view)
            make.height.width.equalTo(44)
            make.top.equalTo(self.view).offset(20)
        })
        self.rightBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.view).offset(-12)
            make.height.width.equalTo(44)
            make.top.equalTo(self.view).offset(20)
        })
        self.logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(75)
            make.top.equalTo(self.view).offset(114)
        }
        self.userNameTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-44)
            make.height.equalTo(55)
            make.top.equalTo(self.logoImageView.snp.bottom).offset(50)
        }
        self.firstLine?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.userNameTF!)
            make.width.equalTo(self.userNameTF!)
            make.bottom.equalTo(self.userNameTF!)
            make.height.equalTo(1)
        })
        self.passWordTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-44)
            make.height.equalTo(55)
            make.top.equalTo(self.userNameTF.snp.bottom)
        }
        self.secondLine?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.userNameTF!)
            make.width.equalTo(self.userNameTF!)
            make.bottom.equalTo(self.passWordTF!)
            make.height.equalTo(1)
        })
        self.loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-92)
            make.height.equalTo(50)
            make.top.equalTo(self.passWordTF.snp.bottom).offset(40)
        }
        self.findPwdBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view)
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.top.equalTo(self.loginBtn!.snp.bottom).offset(25)
        })
    }
    @objc func loginBtnClick() {
        self.view.endEditing(true)
        guard self.userNameTF.text != "", self.passWordTF.text != "" else {
            messageAlert("账号密码不能为空")
            return
        }
        guard self.userNameTF.text!.isTelNumber() else  {
            messageAlert("号码格式不正确")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"mobile":self.userNameTF.text!,"passwd":self.passWordTF.text!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: userLogin, parameters: parData) { (json) in
            
            if json["code"] == "-1" {
                 messageAlert(json["msg"].stringValue)
            }else{
                KeyChain().savekeyChain(dic: ["mobile":json["mobile"].stringValue,"id":json["id"].stringValue,"token":json["token"].stringValue,"headUrl" : json["headUrl"].stringValue,"isLogin" : "1","passwd" : self.passWordTF.text ?? ""])                    
                self.navigationController?.popViewController(animated: false)
            }
            
        }
    }
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func rightBtnClick(){
        let vc = RegistViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func findPwdBtnClick(){
        let vc = FindPwdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
