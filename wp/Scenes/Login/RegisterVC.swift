
//
//  RegisterVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class RegisterVC: BaseTableViewController {
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var voiceCodeText: UITextField!
    @IBOutlet weak var voiceCodeBtn: UIButton!
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
    //获取图片验证码
    @IBAction func changeCodePicture(_ sender: UIButton) {
        if checkoutText(){
            
        }
    }
    //获取声音验证码
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        if checkoutText(){
        
            AppAPIHelper.login().voiceCode(phone: phoneText.text!, complete: { [weak self](result) -> ()? in
                if let strongSelf = self{
                    strongSelf.voiceCodeBtn.isEnabled = false
                    strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.updateBtnTitle), userInfo: nil, repeats: true)
                }
                return nil
            }, error: errorBlockFunc())
        }
    }
    func updateBtnTitle() {
        if codeTime == 0 {
            voiceCodeBtn.isEnabled = true
            voiceCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            return
        }
        voiceCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒后重新发送"
        voiceCodeBtn.setTitle(title, for: .normal)
    }
    //注册
    @IBAction func registerBtnTapped(_ sender: Any) {
        if checkoutText(){
            if checkTextFieldEmpty([phoneText,codeText,voiceCodeText]){
                AppAPIHelper.login().register(phone: phoneText.text!, code: codeText.text!, pwd: voiceCodeText.text!, complete: { [weak self](result) -> ()? in
                   self?.performSegue(withIdentifier: PwdVC.className(), sender: nil)
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
