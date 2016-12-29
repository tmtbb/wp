//
//  LoginVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginVC: BaseTableViewController {
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    
    var loginComplete: CompleteBlock?
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: --DATA
    func initData() {
        NotificationCenter.default.addObserver(self, selector: #selector(errorCode(_:)), name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: nil)
    }
    //MARK: --UI
    func initUI() {
        
    }
    //MARK: --手机号登录
    @IBAction func loginBtnTapped(_ sender: UIButton) {
    
        if checkTextFieldEmpty([phoneText,pwdText]){
            if isTelNumber(num: phoneText.text!) == false{
                SVProgressHUD.showErrorMessage(ErrorMessage: "手机号格式错误", ForDuration: 1, completion: nil)
                return
            }
            AppAPIHelper.login().login(phone: phoneText.text!, pwd: pwdText.text!, complete: { [weak self](result) -> ()? in
                //存储用户信息
                self?.dismissController()
            }, error: errorBlockFunc())
        }
    }
    
    //MARK: --微信登录
    @IBAction func wechatBtnTapped(_ sender: UIButton) {
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    func errorCode(_ notice: NSNotification) {
        
        if let errorCode: Int = notice.object as? Int{
            if errorCode == -4{
                
                return
            }
            if errorCode == -2{
                
                return
            }
            dismissController()
            if loginComplete != nil{
                loginComplete!("" as AnyObject?)
            }
        }
        
    }
    //MARK: --新浪登录
    @IBAction func sinaBtnTapped(_ sender: UIButton) {
        
    }
    //取消登录
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismissController()
    }
}
