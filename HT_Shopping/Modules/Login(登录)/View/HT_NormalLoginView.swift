//
//  HT_NormalLoginView.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/6.
//

import UIKit
//import UleSecurityKit

enum NormalLoginType {
    case NormalLoginAccountType
    case NormalLoginVertifyType
}


class HT_NormalLoginView: UIView {
    
    lazy var phoneInputView : UITextField = {
        let inputView = UITextField()
        inputView.placeholder = "请输入手机号码"
        return inputView
    }()
    lazy var vertyCodeInputView: UITextField = {
        let view =  UITextField()
        view.placeholder = "请输入验证码"
        return view
    }()
    lazy var acountInputView : UITextField = {
        let acount =  UITextField()
        acount.placeholder = "请输入账号"
        return acount
    }()
    lazy var passwordInputView : UITextField = {
        let password = UITextField()
        password.placeholder = "请输入密码"
        password.isSecureTextEntry = true
        return password
    }()
    lazy var checkBoxBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_unagree"), for: .normal)
        btn.setImage(UIImage(named: "login_agree"), for: .selected)
        btn.addTarget(self, action: #selector(agreeClick(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var countDownBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor(rgb: "576B95"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(countDownClick(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var protcolLabel : UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(rgb: "666666")
        label.delegate = self
        let str = "同意《邮乐用户协议》、《隐私权政策》、《中国邮政会员服务协议》、《积分授权及账户绑定条款》及其相关的条款和条件"
        label.isEditable = true
        label.isScrollEnabled = false
        let atttribute = NSMutableAttributedString(string: str)
        atttribute.addAttribute(NSAttributedString.Key.link, value: "uleProtocol://", range: (str as NSString).range(of: "《邮乐用户协议》"))
        atttribute.addAttribute(NSAttributedString.Key.link, value: "yinsiProtocol://", range: (str as NSString).range(of: "《隐私权政策》"))
        atttribute.addAttribute(NSAttributedString.Key.link, value: "yzhyProtocol://", range: (str as NSString).range(of: "《中国邮政会员服务协议》"))
        atttribute.addAttribute(NSAttributedString.Key.link, value: "jifengProtocol://", range: (str as NSString).range(of: "《积分授权及账户绑定条款》"))
        label.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: "576B95")]
        label.attributedText = atttribute
        return label
    }()
    lazy var loginBtn : UIButton = {
        let btn =  UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 20
        btn.setTitle("登录/注册", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return btn
    }()
    lazy var switchLoginType : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("使用账号密码登录", for:.normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(switchButtonClick), for: .touchUpInside)
        return btn
    }()
    var loginType : NormalLoginType = .NormalLoginVertifyType {
        willSet(newType){
            if newType == .NormalLoginAccountType {
                self.accountLoginView.isHidden = false
                self.vertifyLoginView.isHidden = true
                self.switchLoginType.setTitle("手机验证码登录/注册", for: .normal)
                self.loginBtn.setTitle("登 录", for: .normal)
            }else {
                self.accountLoginView.isHidden = true
                self.vertifyLoginView.isHidden = false
                self.switchLoginType.setTitle("使用账号密码登录", for: .normal)
                self.loginBtn.setTitle("登录/注册", for: .normal)
            }
        }
    }
    var accountLoginView: UIView! = nil
    var vertifyLoginView: UIView! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .white
        
        self.vertifyLoginView = self.loadPhoneView()
        addSubview(self.vertifyLoginView)
        self.vertifyLoginView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
        }
        self.accountLoginView = loadAccountView()
        addSubview(self.accountLoginView)
        self.accountLoginView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
        }
        self.accountLoginView.isHidden = true
        addSubview(self.checkBoxBtn)
        self.checkBoxBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self.vertifyLoginView.snp_bottomMargin).offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        addSubview(self.protcolLabel)
        self.protcolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.checkBoxBtn.snp_rightMargin).offset(5)
            make.top.equalTo(self.vertifyLoginView.snp_bottomMargin).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self.protcolLabel.snp_bottomMargin).offset(40)
            make.height.equalTo(40)
        }
        addSubview(self.switchLoginType)
        self.switchLoginType.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self.loginBtn.snp_bottomMargin).offset(5)
            make.height.equalTo(40)
            make.bottom.equalTo(self)
        }
    }
    
    fileprivate func loadAccountView() -> UIView{
        let view = UIView()
        view.addSubview(self.acountInputView)
        view.addSubview(self.passwordInputView)
        self.acountInputView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(70)
        }
        let line = lineView()
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(self.acountInputView.snp_bottomMargin)
            make.height.equalTo(0.6)
        }
        self.passwordInputView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(line.snp_bottomMargin)
            make.height.equalTo(self.acountInputView)
        }
        let bottomLine = lineView()
        view.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(self.passwordInputView.snp_bottomMargin);
            make.height.equalTo(0.6)
            make.bottom.equalTo(view)
        }
        return view
    }
    
    fileprivate func lineView() -> UIView{
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }
    
    fileprivate func loadPhoneView() -> UIView{
        let view = UIView()
        view.addSubview(self.phoneInputView)
        view.addSubview(self.vertyCodeInputView)
        self.phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(70)
        }
        let line = lineView()
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(self.phoneInputView.snp_bottomMargin)
            make.height.equalTo(0.6)
        }
        view.addSubview(self.countDownBtn)
        self.countDownBtn.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp_bottomMargin)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(self.phoneInputView)
        }
        self.vertyCodeInputView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(self.countDownBtn)
            make.top.equalTo(line.snp_bottomMargin)
            make.height.equalTo(self.phoneInputView)
        }
        let bottomLine = lineView()
        view.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(self.vertyCodeInputView.snp_bottomMargin);
            make.height.equalTo(0.6)
            make.bottom.equalTo(view)
        }
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        UIView.addBorder(toView: self.phoneInputView, border: UIEdgeInsets(top: 0, left: 0, bottom: 0.6, right: 0), color: UIColor.lightGray)
//        UIView.addBorder(toView: self.vertyCodeInputView, border: UIEdgeInsets(top: 0, left: 0, bottom: 0.6, right: 0), color: UIColor.lightGray)
//        UIView.addBorder(toView: self.acountInputView, border: UIEdgeInsets(top: 0, left: 0, bottom: 0.6, right: 0), color: UIColor.lightGray)
//        UIView.addBorder(toView: self.passwordInputView, border: UIEdgeInsets(top: 0, left: 0, bottom: 0.6, right: 0), color: UIColor.lightGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension HT_NormalLoginView {
    @objc func countDownClick(btn: UIButton){
        self.countDownBtn.startCountDown(interver: 59, title: "获取验证码", waitTitle: "后重新获取")
    }
    
    @objc func agreeClick(btn: UIButton){
        btn.isSelected = !btn.isSelected
        print("ddddddd")
    }
    
    @objc func switchButtonClick(btn : UIButton){
        print("===")
        if self.loginType == .NormalLoginAccountType {
            self.loginType = .NormalLoginVertifyType
        }else{
            self.loginType = .NormalLoginAccountType
        }
    }
    @objc func loginClick(btn : UIButton){
        print("====登录===")
        
        if UleUserInfor.share.isLogin {
            print("登录成功")
        }else{
            print("未登录")
        }
        
        let ivs : [UInt8] = [13,8,3,16,23,6,11,5]
        let mIVData : NSData = NSData(bytes: ivs, length: 8)
        let nameDes = DESCrypt.encryptUseDES(self.acountInputView.text, key: "6fd4b7f4", iV: mIVData as Data)
        let password = DESCrypt.encryptUseDES(self.passwordInputView.text, key: "6fd4b7f4", iV: mIVData as Data)
        
        let params : [String : Any] = ["userName": nameDes!,"userPassword": password!]
        HN.fetch(API.Login.accountLogin, parameters: params, headers: nil).success { (response) in
            guard response is [String : AnyObject] else {return}
            let dic : [String : AnyObject] = response as! [String : AnyObject]
            if let data = dic["userInfo"] ,let result = UserClassModel.deserialize(from: (data as! Dictionary)) {
                UleUserInfor.save(userInfo: result)
            }
            
        }.failed { (error) in
            print(error)
        }

    }
}

extension HT_NormalLoginView: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        switch URL.scheme {
        case "uleProtocol":
            print("uleProtocol")
            return false
        case "yinsiProtocol":
            print("yinsiProtocol")
            return false
        case "yzhyProtocol":
            print("yinsiProtocol")
            return false
        case "jifengProtocol":
            print("jifengProtocol")
            return false
        default:
            return true
        }
    }
}

extension UIView {
    static func addBorder(toView: UIView,border: UIEdgeInsets, color: UIColor?) -> Void {
        let left = border.left
        let right = border.right
        let top = border.top
        let bottom = border.bottom
        var lineColor = UIColor.lightGray
        if let normolColr = color {
            lineColor = normolColr
        }
        if left > 0 {
            let leftLine = CALayer()
            leftLine.frame = CGRect(x: 0, y: 0, width: left, height: toView.frame.height)
            leftLine.backgroundColor = lineColor.cgColor
            toView.layer.addSublayer(leftLine)
        }
        if right > 0 {
            let rightLine =  CALayer()
            rightLine.frame =  CGRect(x: toView.frame.width-right, y: 0, width: right, height:toView.frame.height )
            rightLine.backgroundColor = lineColor.cgColor
            toView.layer.addSublayer(rightLine)
        }
        if top > 0 {
            let topLine = CALayer()
            topLine.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: top)
            topLine.backgroundColor = lineColor.cgColor
            toView.layer.addSublayer(topLine)
        }
        if bottom > 0 {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: toView.frame.height - bottom, width: toView.frame.width, height: bottom)
            bottomLine.backgroundColor = lineColor.cgColor
            toView.layer.addSublayer(bottomLine)
        }
    
    }
}
