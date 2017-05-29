//
//  RegisterVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
import Kingfisher
class RegisterVC: BaseTableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var thindLoginView: UIView!
    @IBOutlet weak var qqBtn: UIButton!
    @IBOutlet weak var sinaBtn: UIButton!
    @IBOutlet weak var wechatBtn: UIButton!
    @IBOutlet weak var memberText: UITextField!
    @IBOutlet weak var agentText: UITextField!
    @IBOutlet weak var recommendText: UITextField!
    
    private var timer: Timer?
    private var codeTime = 60
    private var voiceCodeTime = 60
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    //MARK: --DATA
    //获取验证码
    @IBAction func changeCodePicture(_ sender: UIButton) {
        if checkoutText(){
            var type = 0
            SVProgressHUD.showProgressMessage(ProgressMessage: "请稍候...")
            if UserModel.share().registerType == .wechatPass {
                type = 2
            }
            sender.isEnabled = false
            AppAPIHelper.commen().verifycode(verifyType: Int64(type), phone: phoneText.text!, complete: { [weak self](result) -> ()? in
                SVProgressHUD.dismiss()
                if let strongSelf = self{
                    if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
                        if let token = resultDic[SocketConst.Key.vToken]{
                            UserModel.share().codeToken = token as! String
                        }
                        if let timestamp = resultDic[SocketConst.Key.timeStamp]{
                            UserModel.share().timestamp = timestamp as! Int 
                        }
                    }
                    strongSelf.codeBtn.isEnabled = false
                    strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.updatecodeBtnTitle), userInfo: nil, repeats: true)
                }
                return nil
                }, error: { (error) in
                    sender.isEnabled = true
                    SVProgressHUD.showErrorMessage(error: error, duration: 2, complete: nil)
                    return nil
            })
        }
    }
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            codeBtn.isEnabled = true
            codeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            timer = nil
            codeBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
            return
        }
        codeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒后重新发送"
        codeBtn.setTitle(title, for: .normal)
        codeBtn.backgroundColor = UIColor.init(rgbHex: 0xCCCCCC)
    }
    //注册
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        if checkoutText(){
            if checkTextFieldEmpty([phoneText,pwdText,codeText,memberText,agentText]){
                sender.isEnabled = false
                UserModel.share().code = codeText.text
                UserModel.share().phone = phoneText.text
                register()
            }
        }
    }
    
    func register() {
        
        let codeStr = AppConst.md5Key + "\(UserModel.share().timestamp)" + UserModel.share().code!
        let codeMd5Str = codeStr.md5()
        if codeMd5Str != UserModel.share().codeToken{
            nextBtn.isEnabled = true
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: AppConst.progressDuration, completion: nil)
            return
        }
        
        if pwdText!.text!.length() < 6 {
            nextBtn.isEnabled = true
            SVProgressHUD.showErrorMessage(ErrorMessage: "密码最少六位数", ForDuration: 2, completion: nil)
            return
        }
        
        //绑定手机号
        if UserModel.share().registerType == .wechatPass {
            SVProgressHUD.showProgressMessage(ProgressMessage: "绑定中...")
            let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
            let param = BingPhoneParam()
            param.phone = phoneText.text!
            param.pwd = password
            param.vCode = UserModel.share().code!
            param.vToken = UserModel.share().codeToken
            param.timeStamp = UserModel.share().timestamp
            if memberText.text!.length() > 0 {
                param.memberId = Int(memberText.text!)!
            }
            param.agentId = agentText.text!
            param.recommend = recommendText.text!
            param.headerUrl = UserModel.share().wechatUserInfo[SocketConst.Key.headimgurl] ?? ""
            param.nickname = UserModel.share().wechatUserInfo[SocketConst.Key.nickname] ?? ""
            param.openid = UserModel.share().wechatUserInfo[SocketConst.Key.openid] ?? ""
            AppAPIHelper.login().bingPhone(param: param, complete: { [weak self](result) -> ()? in
                SVProgressHUD.dismiss()
                self?.nextBtn.isEnabled = true
                if result != nil {
                    UserModel.share().fetchUserInfo(phone: self?.phoneText.text ?? "", pwd: self?.pwdText.text ?? "")
                }else{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "绑定失败，请稍后再试", ForDuration: 1, completion: nil)
                }
                return nil
                }, error: { [weak self](error) in
                    SVProgressHUD.showErrorMessage(error: error, duration: 2, complete: { 
                        self?.nextBtn.isEnabled = true
                    })
                    return nil
            })
            return
        }
        
        
        //注册
        let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
        let param = RegisterParam()
        param.phone = phoneText.text!
        param.pwd = password
        param.vCode = UserModel.share().code!
        param.vToken = UserModel.share().codeToken
        param.timeStamp = UserModel.share().timestamp
        if memberText.text!.length() > 0 {
            param.memberId = Int(memberText.text!)!
        }
        param.agentId = agentText.text!
        param.recommend = recommendText.text!
        SVProgressHUD.showProgressMessage(ProgressMessage: "注册中...")
        AppAPIHelper.login().register(model: param, complete: { [weak self](result) -> ()? in
            SVProgressHUD.dismiss()
            if result != nil {
                SVProgressHUD.showSuccessMessage(SuccessMessage: "注册成功!", ForDuration: 2, completion: nil)
                UserModel.share().fetchUserInfo(phone: self?.phoneText.text ?? "", pwd: self?.pwdText.text ?? "")
            }else{
                SVProgressHUD.showErrorMessage(ErrorMessage: "注册失败，请稍后再试", ForDuration: 1, completion: nil)
            }
            return nil
        }, error: errorBlockFunc())

    }

    func checkoutText() -> Bool {
        if checkTextFieldEmpty([phoneText]) {
            if isTelNumber(num: phoneText.text!) == false{
                SVProgressHUD.showErrorMessage(ErrorMessage: "手机号格式错误", ForDuration: 1, completion: nil)
                return false
            }
            return true
        }
        return false
    }
    //MARK: --UI
    func initUI() {
        title =  UserModel.share().registerType == .wechatPass ? "绑定手机号":"注册"
        let nextTitle =  UserModel.share().registerType == .wechatPass ? "绑定":"注册"
        nextBtn.setTitle(nextTitle, for: .normal)
        phoneView.layer.borderWidth = 0.5
        pwdText.placeholder = "请输入登录密码"
        phoneView.layer.borderColor = UIColor.init(rgbHex: 0xcccccc).cgColor
        
        codeBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        nextBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        qqBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        wechatBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        sinaBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)

        let eyeBtn: UIButton = UIButton.init(type: .custom)
        eyeBtn.setImage(UIImage.init(named: "eye_close"), for: .normal)
        eyeBtn.setImage(UIImage.init(named: "eye_open"), for: .selected)
        eyeBtn.addTarget(self, action: #selector(eyeBtnTapped(_ :)), for: .touchUpInside)
        pwdText.rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        pwdText.rightView?.addSubview(eyeBtn)
        pwdText.rightViewMode = .always
        eyeBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 22, height: 22))
        }
    }
    
    func eyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        pwdText.isSecureTextEntry = !sender.isSelected
    }

    //MARK: --TextFeild密码处理
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pwdText{
            let text: String = textField.text ?? ""
            return string == "" || text.length() < 16
        }
        return true
    }
    
}
