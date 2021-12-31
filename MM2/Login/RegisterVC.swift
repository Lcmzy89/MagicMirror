//
//  RegisterVC.swift
//  MM
//
//  Created by 李成明 on 2021/12/30.
//

import UIKit
import Toast_Swift
import CLImagePickerTool

class RegisterVC: MViewController {
    
    private var canRegister: Bool = false {
        willSet {
            if canRegister == newValue { return }
            if newValue {
                registerBtn.isUserInteractionEnabled = true
                registerBtn.backgroundColor = UIColor.initWithRGB(67, 147, 247)
            } else {
                registerBtn.isUserInteractionEnabled = false
                registerBtn.backgroundColor = UIColor.initWithRGB(210, 210, 210)
            }
            
        }
    }
    
    private var isSelectAvatar = false
    
    private lazy var avatar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "add_avatar_img")
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(avatarClick))
        view.addGestureRecognizer(tap)
        return view
    }()

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
    
    
    private lazy var confirmIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "password_lock_icon")
        return view
    }()
    
    private lazy var confirmTextView: UITextField = {
        let view = UITextField()
        view.font = textFont
        view.delegate = self
        view.placeholder = "请确认密码"
        return view
    }()
    
    private lazy var confirmUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.initWithRGB(210, 210, 210)
        return view
    }()
    
    private lazy var registerBtn: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.initWithRGB(210, 210, 210)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.titleLabel?.font = .systemFont(ofSize: 18)
        view.setTitle("注册", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.isUserInteractionEnabled = false
        
        view.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        return view
    }()
    
    private lazy var goLoginBtn: UIButton = {
        let view = UIButton()
        view.setTitleColor(.initWithRGB(97, 167, 247), for: .normal)
        view.setTitle("已注册？去登录", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension RegisterVC {
    private func setupUI() {
        view.addsubViews([avatar, userNameIcon, nameTextView, nameUnderLine, psdWordTextView, passWordIcon, pasWordUnderLine, confirmIcon, confirmTextView, confirmUnderLine, registerBtn, goLoginBtn])
        
        var y = 100.0
        let x = (kScreenWidth - 25 - 250)/2
        avatar.frame = CGRect(x: (kScreenWidth - 120)/2, y: y, width: 120, height: 120)
        
        y += 150
        userNameIcon.frame = CGRect(x: x, y: y + 3, width: 16, height: 16)
        nameTextView.frame = CGRect(x: x + 25, y: y, width: 250 - 5, height: 20)
        nameUnderLine.frame = CGRect(x: x + 25, y: y + 20 + 3, width: 250, height: 1)
        
        y += 50
        passWordIcon.frame = CGRect(x: x, y: y + 3, width: 16, height: 16)
        psdWordTextView.frame = CGRect(x: x + 25, y: y, width: 220 - 5, height: 20)
        pasWordUnderLine.frame = CGRect(x: x + 25, y: y + 20 + 3, width: 250, height: 1)
        
         y += 50
        confirmIcon.frame = CGRect(x: x, y: y + 3, width: 16, height: 16)
        confirmTextView.frame = CGRect(x: x + 25, y: y, width: 250 - 5, height: 20)
        confirmUnderLine.frame = CGRect(x: x + 25, y: y + 20 + 3, width: 250, height: 1)
        
        y += 70
        registerBtn.frame = CGRect(x: x, y: y, width: kScreenWidth - x*2, height: 40)
        goLoginBtn.frame = CGRect(x: (kScreenWidth - 120) - x, y: y + 60, width: 120, height: 20)
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === nameTextView {
            if (textField.text?.count ?? 0) + string.count > 10 { return false }
            return true
        } else if textField ===  psdWordTextView {
            if  string.count == 0 { return true}
            if (textField.text?.count ?? 0) + string.count > 16 || !Util.isLetterWithDigital(string) { return false }
            return true
        } else if textField === confirmTextView {
            if  string.count == 0 { return true}
            if (textField.text?.count ?? 0) + string.count > 16 || !Util.isLetterWithDigital(string) { return false }
            return true
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let pasWord = psdWordTextView.text, let name = nameTextView.text, let confirmText = confirmTextView.text else {
            canRegister = false
            return
        }
        canRegister = !name.isEmpty && (pasWord.count >= 6 && pasWord.count <= 16) && !confirmText.isEmpty
    }
}

// MARK: Action
extension RegisterVC {
    @objc private func registerClick() {
        if !isSelectAvatar {
            view.makeToast("你还没有选择头像哦")
            return
        }
        
        if psdWordTextView.text != confirmTextView.text {
            view.makeToast("两次密码不一致")
            return
        }
    }
    
    @objc private func goLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func avatarClick() {
        let imgTool = CLImagePickerTool()
        imgTool.singleImageChooseType = .singlePicture
        imgTool.cl_setupImagePickerWith(MaxImagesCount: 1, superVC: self) { asset, image in
            CLImagePickerTool.convertAssetArrToOriginImage(assetArr: asset, scale: 1) { img, _ in
                self.avatar.image = img
            } failedClouse: {
                self.view.makeToast("你既然看到了这个，那应该是出bug了")
            }
        }
    }
}
