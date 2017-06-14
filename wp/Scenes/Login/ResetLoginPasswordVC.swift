//
//  ResetLoginPasswordVC.swift
//  wp
//
//  Created by mu on 2017/4/26.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
class ResetLoginPasswordVC: BaseTableViewController {

    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pwdText: UITextField!
    private var timer: Timer?
    private var codeTime = 60
    
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
 
    //获取验证码
    @IBAction func changeCodePicture(_ sender: UIButton) {
        if checkoutText(){
            let type = 1
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
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if checkoutText(){
            if checkTextFieldEmpty([phoneText,pwdText,codeText]){
                UserModel.share().code = codeText.text
                UserModel.share().phone = phoneText.text
                resetpwd()
            }
        }
    }
    
    func resetpwd() {
       
        let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
        let param = ResetPwdParam()
        param.phone = phoneText.text!
        param.pwd = password
        param.vCode = UserModel.share().code!
        param.vToken = UserModel.share().codeToken
        param.timestamp = UserModel.share().timestamp
        SVProgressHUD.showProgressMessage(ProgressMessage: "重置中...")
        AppAPIHelper.login().repwd(param: param, complete: { [weak self](result) -> ()?in
            SVProgressHUD.dismiss()
            if let status: Int = result?["status"] as? Int{
                if status == 0{
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "重置成功", ForDuration: 2, completion: nil)
                    _ = self?.navigationController?.popToRootViewController(animated: true)
                }else{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "重置失败", ForDuration: 2, completion: nil)
                }
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
        phoneView.layer.borderWidth = 0.5
        pwdText.placeholder = "请输入登录密码"
        phoneView.layer.borderColor = UIColor.init(rgbHex: 0xcccccc).cgColor
        codeBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        nextBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
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


}
