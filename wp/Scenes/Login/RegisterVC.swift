
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
class RegisterVC: BaseTableViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var voiceCodeText: UITextField!
    @IBOutlet weak var voiceCodeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var thindLoginView: UIView!
    @IBOutlet weak var qqBtn: UIButton!
    @IBOutlet weak var sinaBtn: UIButton!
    @IBOutlet weak var wechatBtn: UIButton!
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
            let type = UserModel.share().forgetPwd ? 1:0
            SVProgressHUD.showProgressMessage(ProgressMessage: "请稍候...")
            AppAPIHelper.commen().verifycode(verifyType: Int64(type), phone: phoneText.text!, complete: { [weak self](result) -> ()? in
                SVProgressHUD.dismiss()
                if let strongSelf = self{
                    if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
                        if let token = resultDic[SocketConst.Key.vToken]{
                            UserModel.share().codeToken = token as! String
                        }
                        if let timestamp = resultDic[SocketConst.Key.timestamp]{
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
    //获取声音验证码
    
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        if checkoutText(){

        }
    }
    func updateVoiceBtnTitle() {
        if voiceCodeTime == 0 {
            voiceCodeBtn.isEnabled = true
            voiceCodeBtn.setTitle("重新发送", for: .normal)
            voiceCodeTime = 60
            timer?.invalidate()
            voiceCodeBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
            return
        }
        voiceCodeBtn.isEnabled = false
        voiceCodeTime = voiceCodeTime - 1
        let title: String = "\(voiceCodeTime)秒后重新发送"
        voiceCodeBtn.setTitle(title, for: .normal)
        voiceCodeBtn.backgroundColor = UIColor.init(rgbHex: 0xCCCCCC)
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
        //重置密码
        if UserModel.share().forgetPwd {
            SVProgressHUD.showProgressMessage(ProgressMessage: "重置中...")
            let type = UserModel.share().forgetType == nil ? .loginPass : UserModel.share().forgetType
            let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
            AppAPIHelper.login().repwd(phone: UserModel.share().phone!, type: (type?.rawValue)!,  pwd: password, code: UserModel.share().code!, complete: { [weak self](result) -> ()? in
                
                SVProgressHUD.showWainningMessage(WainningMessage: "重置成功", ForDuration: 1, completion: nil)
                _ = self?.navigationController?.popToRootViewController(animated: true)
                return nil
                }, error: errorBlockFunc())
            return
        }
        
        //注册
        SVProgressHUD.showProgressMessage(ProgressMessage: "注册中...")
        let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
        AppAPIHelper.login().register(phone: UserModel.share().phone!, code: UserModel.share().code!, pwd: password, complete: { [weak self](result) -> ()? in
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
        title = UserModel.share().forgetPwd ? "重置密码":"注册"
        thindLoginView.isHidden = UserModel.share().forgetPwd
        phoneView.layer.borderWidth = 0.5
        pwdText.placeholder = UserModel.share().forgetPwd ? "请输入支付密码":"请输入登录密码"
        if UserModel.share().forgetType == .loginPass {
            pwdText.placeholder = "请输入登录密码"
        }
        phoneView.layer.borderColor = UIColor.init(rgbHex: 0xcccccc).cgColor
        
        codeBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        nextBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        qqBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        wechatBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        sinaBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)

    }

    
}
