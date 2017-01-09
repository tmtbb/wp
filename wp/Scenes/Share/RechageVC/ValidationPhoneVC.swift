//
//  ValidationPhoneVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ValidationPhoneVC: BaseTableViewController {
    @IBOutlet weak var voiceCodeBtn: UIButton!
    private var timer: Timer?
    private var codeTime = 60
    override func viewDidLoad() {
        super.viewDidLoad()

       title = "输入手机号"
        
    }
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
            }, error: errorBlockFunc())
        
    }
    //MARK: --点击发送验证码
    @IBAction func requestVoiceCode(_ sender: UIButton) {
          self.voiceCodeBtn.isEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateBtnTitle), userInfo: nil, repeats: true)
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
   
}
