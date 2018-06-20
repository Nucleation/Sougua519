//
//  RegistViewController.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var logoImageView: UIImageView!
    var userNameTF: UITextField!
    var unLeftView: UIImageView!
    var passWordTF: UITextField!
    var pwLeftView: UIImageView!
    var registNewBtn: UIButton!
    var codeTF:UITextField!
    var cLeftView: UIImageView!
    var getCodeBtn: UIButton!
    var countdownTimer: Timer?
    var firstLine: UIImageView?
    var secondLine: UIImageView?
    var thirdLine: UIImageView?
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
        self.view.backgroundColor = .white
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI(){
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        self.leftBtn = leftBtn
        let rightBtn = UIButton(type: .custom)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.setTitle("登录", for: .normal)
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
        let codeTF = UITextField()
        codeTF.placeholder = "验证码"
        let cLeftView = UIImageView(image: UIImage(named: "codeImage"))
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
        getCodeBtn.setTitleColor(UIColor.red, for: .normal)
        getCodeBtn.backgroundColor = UIColor.clear
        getCodeBtn.addTarget(self, action: #selector(getCodeBtnClick), for: .touchUpInside)
        self.view.addSubview(getCodeBtn)
        self.getCodeBtn = getCodeBtn
        let registNewBtn = UIButton(type: .custom)
        registNewBtn.layer.cornerRadius = 25
        registNewBtn.setTitle("注册", for: .normal)
        registNewBtn.setTitleColor(UIColor.white, for: .normal)
        registNewBtn.backgroundColor = .colorAccent
        registNewBtn.addTarget(self, action: #selector(registBtnClick), for: .touchUpInside)
        registNewBtn.tag = 0
        self.view.addSubview(registNewBtn)
        self.registNewBtn = registNewBtn
        let firstLine = UIImageView()
        firstLine.backgroundColor = UIColor.colorWithHexColorString("eeeeee")
        self.view.addSubview(firstLine)
        self.firstLine = firstLine
        let secondLine = UIImageView()
        secondLine.backgroundColor = UIColor.colorWithHexColorString("eeeeee")
        self.view.addSubview(secondLine)
        self.secondLine = secondLine
        let thirdLine = UIImageView()
        thirdLine.backgroundColor = UIColor.colorWithHexColorString("eeeeee")
        self.view.addSubview(thirdLine)
        self.thirdLine = thirdLine
        self.leftBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view)
            make.height.width.equalTo(44)
            make.top.equalTo(self.view).offset(20)
        })
//        self.rightBtn?.snp.makeConstraints({ (make) in
//            make.right.equalTo(self.view).offset(-12)
//            make.height.width.equalTo(44)
//            make.top.equalTo(self.view).offset(20)
//        })
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
        self.codeTF.snp.remakeConstraints{ (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-44)
            make.height.equalTo(55)
            make.top.equalTo(self.passWordTF.snp.bottom)
        }
        self.thirdLine?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.userNameTF!)
            make.width.equalTo(self.userNameTF!)
            make.bottom.equalTo(self.codeTF!)
            make.height.equalTo(1)
        })
        self.registNewBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).offset(-92)
            make.height.equalTo(50)
            make.top.equalTo(self.codeTF.snp.bottom).offset(40)
        }
        self.getCodeBtn.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(self.codeTF)
            make.right.equalTo(self.codeTF)
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
        let dic: Dictionary<String, Any> = ["mobile":self.userNameTF.text ?? "","timestamp":String(timeInterval)]
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
    @objc func registBtnClick() {
        guard self.userNameTF.text != "", self.passWordTF.text != "" ,self.passWordTF.text != "" else {
            print("账号/密码/验证码不能为空")
            return
        }
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"mobile":self.userNameTF.text!,"passwd":self.passWordTF.text!,"securityCode":self.codeTF.text!]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: userRegister, parameters: parData) { (json) in
            self.rightBtnClick()
        }
    }
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func rightBtnClick(){
        let vc = LoginViewController()
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
