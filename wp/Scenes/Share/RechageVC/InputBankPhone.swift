//
//  InputBankPhone.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class InputBankPhone: UITableViewController {
    
    // 卡片类型
    @IBOutlet weak var typeBank: UITextField!
    // 银行手机号
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "输入手机号"
        
    }
    
    
    @IBAction func addBank(_ sender: Any) {
        
        
        if checkTextFieldEmpty([typeBank,phone]){
            
            if isTelNumber(num: phone.text!) == false{
                
                SVProgressHUD.showErrorMessage(ErrorMessage: "手机号格式错误", ForDuration: 1, completion: nil)
                return
            }
            self.performSegue(withIdentifier: "sendCode", sender: nil)
            
            return
        }
        
    }
    
    
    
}
