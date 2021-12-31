//
//  LoginVC.swift
//  MM
//
//  Created by 李成明 on 2021/12/30.
//

import UIKit
import SnapKit

let textFont = UIFont.systemFont(ofSize: 16)
class LoginVC: MViewController {

    private var canLogin: Bool = false {
        willSet {
            if canLogin == newValue { return }
            if newValue {
                loginBtn.isUserInteractionEnabled = true
                loginBtn.backgroundColor = UIColor.initWithRGB(67, 147, 247)
            } else {
                loginBtn.isUserInteractionEnabled = false
                loginBtn.backgroundColor = UIColor.initWithRGB(210, 210, 210)
            }
        }
    }
    private lazy var userNameIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "login_little_man")
        return view
    }()
    
    private lazy var passWordIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "password_lock_icon")
        return view
    }()
    
    private lazy var nameTextView: UITextField = {
        let view = UITextField()
        view.font = textFont
        view.delegate = self
        view.placeholder = "请输入用户名"
        return view
    }()
    
    private lazy var nameUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.initWithRGB(210, 210, 210)
        return view
    }()
    
    private lazy var psdWordTextView: UITextField = {
        let view = UITextField()
        view.font = textFont
        view.delegate = self
        view.placeholder = "请输入密码(6-16位)"
        return view
    }()
    
    private lazy var pasWordUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.initWithRGB(210, 210, 210)
        return view
    }()
    
    
    private lazy var loginBtn: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.initWithRGB(210, 210, 210)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.titleLabel?.font = .systemFont(ofSize: 18)
        view.setTitle("登录", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.isUserInteractionEnabled = false
        
        view.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return view
    }()
    
    private lazy var leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .initWithRGB(189, 189, 189)
        view.alpha = 0.3
        return view
    }()
    
    private lazy var rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .initWithRGB(189, 189, 189)
        view.alpha = 0.3
        return view
    }()
    
    private lazy var otherLogin: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .initWithRGB(189, 189, 189)
        view.text = "其他登录方式"
        return view
    }()
    
    private lazy var weixinImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "weixin")
        return view
    }()
    private lazy var qqImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "QQ")
        return view
    }()
    private lazy var weiboImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "weibo")
        return view
    }()
    
    private lazy var registerBtn: UIButton = {
        let view = UIButton()
        view.setTitleColor(.initWithRGB(97, 167, 247), for: .normal)
        view.setTitle("没有账号？去注册", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.addTarget(self, action: #selector(goRegister), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension LoginVC {
    private func setupUI() {
        view.backgroundColor = .white
        view.addsubViews([userNameIcon, passWordIcon, nameTextView, nameUnderLine, psdWordTextView, pasWordUnderLine, loginBtn, registerBtn, leftLine, rightLine, otherLogin, qqImage, weixinImage, weiboImage])
        
        var y = 200 // 我知道这样写很傻，可惜我是写了一部分之后才意识到 改是不可能改的
        let x = Int((kScreenWidth - 25 - 220)/2)
        userNameIcon.frame = CGRect(x: x, y: y + 3, width: 16, height: 16)
        nameTextView.frame = CGRect(x: x + 25, y: y, width: 220 - 5, height: 20)
        nameUnderLine.frame = CGRect(x: x + 25, y: y + 20 + 3, width: 220, height: 1)
        
        y += 100
        passWordIcon.frame = CGRect(x: x, y: y + 3, width: 16, height: 16)
        psdWordTextView.frame = CGRect(x: x + 25, y: y, width: 220 - 5, height: 20)
        pasWordUnderLine.frame = CGRect(x: x + 25, y: y + 20 + 3, width: 220, height: 1)
        
        y += 100
        loginBtn.frame = CGRect(x: x, y: y, width: Int(kScreenWidth) - x*2, height: 40)
        registerBtn.frame = CGRect(x: Int((kScreenWidth - 150)/2), y: y + 60, width: 150, height: 20)
        
        y += 150
        let otherTextSize = otherLogin.sizeThatFits(CGSize(width: kScreenWidth, height: CGFloat.greatestFiniteMagnitude))
        let lineW = (kScreenWidth - 40 - otherTextSize.width - 30)/2
        leftLine.frame = CGRect(x: 20.0, y: CGFloat(y), width: lineW, height: 1)
        otherLogin.frame = CGRect(x: 20 + lineW + 15, y: CGFloat(y) - otherTextSize.height/2, width: otherTextSize.width, height: otherTextSize.height)
        rightLine.frame = CGRect(x: 20 + lineW + 15 + otherTextSize.width + 15, y: CGFloat(y), width: lineW, height: 1)
        
        y += 50
        let iconW = 30
        let iconSpace = 20
        let iconX = (Int(kScreenWidth) - iconW * 3 - iconSpace * 2)/2
        qqImage.frame = CGRect(x: iconX, y: y, width: iconW, height: iconW)
        weixinImage.frame = CGRect(x: iconX + iconW + iconSpace, y: y, width: iconW, height: iconW)
        weiboImage.frame = CGRect(x: iconX + iconW*2 + iconSpace*2, y: y, width: iconW, height: iconW)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === nameTextView {
            if (textField.text?.count ?? 0) + string.count > 10 { return false }
            return true
        } else if textField ===  psdWordTextView {
            if  string.count == 0 { return true}
            if (textField.text?.count ?? 0) + string.count > 16 || !Util.isLetterWithDigital(string) { return false }
            return true
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let pasWord = psdWordTextView.text, let name = nameTextView.text else {
            canLogin = false
            return
        }
        canLogin = !name.isEmpty && (pasWord.count >= 6 && pasWord.count <= 16)
    }
}

// MARK: Action
extension LoginVC {
    @objc private func loginBtnClick() {
        print("点击登录")
    }
    
    @objc private func goRegister() {
        self.navigationController?.pushViewController(RegisterVC(), animated: true)
    }
}
