//
//  BingPhoneVC.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class BingPhoneVC: BaseTableViewController {

    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    private var timer: Timer?
    private var codeTime = 60
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        
    }

    //获取声音验证码
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        if checkoutText(){
            
            AppAPIHelper.login().voiceCode(phone: phoneText.text!, complete: { [weak self](result) -> ()? in
                if let strongSelf = self{
                    strongSelf.codeBtn.isEnabled = false
                    strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.updateBtnTitle), userInfo: nil, repeats: true)
                }
                return nil
                }, error: errorBlockFunc())
        }
    }
    func updateBtnTitle() {
        if codeTime == 0 {
            codeBtn.isEnabled = true
            codeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            return
        }
        codeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒后重新发送"
        codeBtn.setTitle(title, for: .normal)
    }
    //绑定手机号
    @IBAction func registerBtnTapped(_ sender: Any) {
        if checkoutText(){
            if checkTextFieldEmpty([phoneText,codeText]){
                SVProgressHUD.showProgressMessage(ProgressMessage: "绑定中...")
                AppAPIHelper.login().register(phone: phoneText.text!, code: codeText.text!, pwd: codeText.text!, complete: { [weak self](result) -> ()? in
                    SVProgressHUD.dismiss()
                    if result != nil {
                        self?.performSegue(withIdentifier: AppConst.NotifyDefine.BingPhoneVCToPwdVC, sender: nil)
                    }else{
                        SVProgressHUD.showErrorMessage(ErrorMessage: "登录失败，请稍后再试", ForDuration: 1, completion: nil)
                    }
                    return nil
                    }, error: errorBlockFunc())
            }
        }
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

    }


}
