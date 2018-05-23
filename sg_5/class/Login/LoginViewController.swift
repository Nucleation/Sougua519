//
//  LoginViewController.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/5/10.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var logoImageView: UIImageView!
    var userNameTF: UITextField!
    var unLeftView: UIImageView!
    var passWordTF: UITextField!
    var pwLeftView: UIImageView!
    var loginBtn: UIButton!
    var registNewBtn: UIButton!
    var remberBtn: UIButton!
    var forgotBtn: UIButton!
    var codeTF:UITextField!
    var cLeftView: UIImageView!
    var getCodeBtn: UIButton!
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    func createUI(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [UIColor.colorWithHexColorString( "80d8ee").cgColor, UIColor.colorWithHexColorString("66b3f4").cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        self.view.addSubview(logoImageView)
        self.logoImageView = logoImageView
        let userNameTF = UITextField()
        userNameTF.placeholder = "请输入手机号"
        userNameTF.layer.cornerRadius = 25
        userNameTF.backgroundColor = UIColor.colorWithHexColorString("7cd2ef")
        userNameTF.leftViewMode = UITextFieldViewMode.always
        let unLeftView = UIImageView(image: UIImage(named: "shouji"))
        unLeftView.frame = CGRect(x: 18, y: 0, width: 60, height: 50)
        unLeftView.contentMode = UIViewContentMode.center
        self.unLeftView = unLeftView
        userNameTF.leftView = unLeftView
        self.view.addSubview(userNameTF)
        self.userNameTF = userNameTF
        let passWordTF = UITextField()
        passWordTF.placeholder = "请输入密码"
        passWordTF.isSecureTextEntry = true
        passWordTF.layer.cornerRadius = 25
        passWordTF.backgroundColor = UIColor.colorWithHexColorString( "7cd2ef")
        let pwLeftView = UIImageView(image: UIImage(named: "mima"))
        passWordTF.leftViewMode = UITextFieldViewMode.always
        pwLeftView.frame = CGRect(x: 18, y: 0, width: 60, height: 50)
        pwLeftView.contentMode = UIViewContentMode.center
        self.pwLeftView = pwLeftView
        passWordTF.leftView = pwLeftView
        self.view.addSubview(passWordTF)
        self.passWordTF = passWordTF
        let codeTF = UITextField()
        codeTF.layer.cornerRadius = 25
        codeTF.backgroundColor = UIColor.colorWithHexColorString( "7cd2ef")
        let cLeftView = UIImageView(image: UIImage(named: "yanzhengma"))
        codeTF.leftViewMode = UITextFieldViewMode.always
        cLeftView.frame = CGRect(x: 18, y: 0, width: 60, height: 50)
        cLeftView.contentMode = UIViewContentMode.center
        self.cLeftView = cLeftView
        codeTF.leftView = cLeftView
        self.view.addSubview(codeTF)
        self.codeTF = codeTF
        let getCodeBtn = UIButton(type: .custom)
        getCodeBtn.setTitle("获取验证码", for: .normal)
        getCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        getCodeBtn.setTitleColor(UIColor.white, for: .normal)
        getCodeBtn.backgroundColor = UIColor.clear
        getCodeBtn.addTarget(self, action: #selector(getCodeBtnClick), for: .touchUpInside)
        self.view.addSubview(getCodeBtn)
        self.getCodeBtn = getCodeBtn
        let loginBtn = UIButton(type: .custom)
        loginBtn.layer.cornerRadius = 25
        loginBtn.setTitle("登陆", for: .normal)
        loginBtn.setTitleColor(UIColor.colorWithHexColorString( "7cd2ef"), for: .normal)
        loginBtn.backgroundColor = UIColor.white
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        loginBtn.tag = 0
        self.view.addSubview(loginBtn)
        self.loginBtn = loginBtn
        let registNewBtn = UIButton(type: .custom)
        registNewBtn.setTitle("创建新用户", for: .normal)
        registNewBtn.setTitleColor(UIColor.white, for: .normal)
        registNewBtn.backgroundColor = UIColor.clear
        registNewBtn.addTarget(self, action: #selector(registNewBtnClick), for: .touchUpInside)
        self.view.addSubview(registNewBtn)
        self.registNewBtn = registNewBtn
        let remberBtn = UIButton(type: .custom)
        remberBtn.setImage(UIImage(named: "gouxuan"), for: .normal)
        remberBtn.setTitle("记住我?", for: .normal)
        remberBtn.titleLabel?.textAlignment = NSTextAlignment.right
        remberBtn.setTitleColor(UIColor.white, for: .normal)
        remberBtn.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(remberBtn)
        self.remberBtn = remberBtn
        let forgotBtn = UIButton(type: .custom)
        let attrStr = NSAttributedString(string: "忘记密码", attributes: [NSAttributedStringKey.underlineStyle : 1,NSAttributedStringKey.foregroundColor:UIColor.white])
        forgotBtn.setAttributedTitle(attrStr, for: .normal)
        forgotBtn.backgroundColor = UIColor.clear
        forgotBtn.tag = 0
        forgotBtn.addTarget(self, action: #selector(forgotBtnClick), for: .touchUpInside)
        self.view.addSubview(forgotBtn)
        self.forgotBtn = forgotBtn
        self.logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(120)
            make.top.equalTo(self.view).offset(85)
        }
        self.userNameTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-74)
            make.height.equalTo(50)
            make.top.equalTo(self.logoImageView.snp.bottom).offset(70)
        }
        self.passWordTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-74)
            make.height.equalTo(50)
            make.top.equalTo(self.userNameTF.snp.bottom).offset(15)
        }
        self.loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-74)
            make.height.equalTo(50)
            make.top.equalTo(self.passWordTF.snp.bottom).offset(15)
        }
        self.registNewBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-74)
            make.height.equalTo(17)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(15)
        }
        self.remberBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(37)
            make.bottom.equalTo(self.view).offset(-31)
            make.width.equalTo(120)
            make.height.equalTo(32)
        }
        self.forgotBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.remberBtn)
            make.right.equalTo(self.view).offset(-41)
            make.size.equalTo(self.remberBtn)
        }
        self.codeTF.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.loginBtn)
            make.right.equalTo(self.view).offset(-1000)
            make.size.equalTo(self.loginBtn)
        }
        self.getCodeBtn.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(self.codeTF)
            make.right.equalTo(self.codeTF).offset(-15)
            make.width.equalTo(150)
        }
    }
    @objc func getCodeBtnClick(){
        guard self.userNameTF.text != "" else {
            print("账号为空")
            return
        }
        let urlStr = ucenterGetSecurityCode
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["mobile":self.userNameTF.text ?? "","timestamp":String(timeInterval)]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: urlStr, parameters: parData ) { (result) in
            print(result)  
        }
         isCounting = true
    }
    @objc func forgotBtnClick(){
        switch self.forgotBtn.tag {
        case 0:
            break
        default:
            self.loginBtn.setTitle("登录", for:.normal)
            self.loginBtn.tag = 0
            let attrStr = NSAttributedString(string: "忘记密码", attributes: [NSAttributedStringKey.underlineStyle : 1,NSAttributedStringKey.foregroundColor:UIColor.white])
            self.forgotBtn.setAttributedTitle(attrStr, for: .normal)
            self.forgotBtn.tag = 0
            self.codeTF.snp.remakeConstraints{ (make) in
                make.centerX.equalTo(self.view).offset(1000)
                make.top.equalTo(self.passWordTF.snp.bottom).offset(15)
                make.size.equalTo(self.loginBtn)
            }
            self.loginBtn.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.width.equalTo(self.view).offset(-74)
                make.height.equalTo(50)
                make.top.equalTo(self.passWordTF.snp.bottom).offset(15)
            }
            self.registNewBtn.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.width.equalTo(self.view).offset(-74)
                make.height.equalTo(17)
                make.top.equalTo(self.loginBtn.snp.bottom).offset(15)
            }
        }
    }
    @objc func registNewBtnClick(){
        switch loginBtn.tag {
        case 0:
            self.loginBtn.setTitle("注册", for:.normal)
            self.loginBtn.tag = 1
            let attrStr = NSAttributedString(string: "去登陆", attributes: [NSAttributedStringKey.underlineStyle : 1,NSAttributedStringKey.foregroundColor:UIColor.white])
            self.forgotBtn.setAttributedTitle(attrStr, for: .normal)
            self.forgotBtn.tag = 1
            self.codeTF.snp.remakeConstraints{ (make) in
                make.centerX.equalTo(self.view)
                make.top.equalTo(self.passWordTF.snp.bottom).offset(15)
                make.size.equalTo(self.loginBtn)
            }
            self.loginBtn.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.width.equalTo(self.view).offset(-74)
                make.height.equalTo(50)
                make.top.equalTo(self.codeTF.snp.bottom).offset(15)
            }
            self.registNewBtn.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.view).offset(1000)
                make.width.equalTo(self.view).offset(-74)
                make.height.equalTo(17)
                make.top.equalTo(self.loginBtn.snp.bottom).offset(15)
            }
        default:
            break
        }
    }
    @objc func loginBtnClick() {
        switch self.loginBtn.tag {
        case 0:
            login()
        default:
            register()
        }
    }
    func login() {
        guard self.userNameTF.text != "", self.passWordTF.text != "" else {
            print("账号密码不能为空")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"mobile":self.userNameTF.text!,"passwd":self.passWordTF.text!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: userLogin, parameters: parData) { (json) in
            KeyChain().savekeyChain(dic: ["mobile":json["mobile"].stringValue,"id":json["id"].stringValue,"token":json["token"].stringValue])
            print(KeyChain().getKeyChain())
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    func register() {
        guard self.userNameTF.text != "", self.passWordTF.text != "" ,self.passWordTF.text != "" else {
            print("账号/密码/验证码不能为空")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, String> = ["timestamp":String(timeInterval),"mobile":self.userNameTF.text!,"passwd":self.passWordTF.text!,"securityCode":self.codeTF.text!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: userRegister, parameters: parData) { (json) in
            print(json)
        }
    }
    @objc func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
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
