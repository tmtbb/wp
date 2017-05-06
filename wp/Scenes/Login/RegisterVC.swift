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
class RegisterVC: BaseTableViewController {
    
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
            let type = 0
            SVProgressHUD.showProgressMessage(ProgressMessage: "请稍候...")
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
            }, error: errorBlockFunc())
        }
    }
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            codeBtn.isEnabled = true
            codeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
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
    @IBAction func registerBtnTapped(_ sender: Any) {
        if checkoutText(){
            if checkTextFieldEmpty([phoneText,pwdText,codeText]){
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
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: AppConst.progressDuration, completion: nil)
            return
        }
        
        //重置密码
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
                if result != nil {
                    UserModel.share().fetchUserInfo(phone: self?.phoneText.text ?? "", pwd: self?.pwdText.text ?? "")
                }else{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "绑定失败，请稍后再试", ForDuration: 1, completion: nil)
                }
                return nil
            }, error: errorBlockFunc())
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

    }

    
}
