//
//  FullBankInfomationVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

//进入输入手机号界面
 let pushInputPhone:String = "pushInputPhone"
//pushInputPhone
class FullBankInfomationVC: BaseTableViewController {


    
    // 银行预留手机号
    @IBOutlet weak var bankNumber: UITextField!
    
    // 持卡人姓名
    @IBOutlet weak var name: UITextField!
   
    
    
    override func viewDidLoad() {
        
        title = "输入银行卡信息"
        
        super.viewDidLoad()

      
    }
    @IBAction func nextInputPhone(_ sender: Any) {
        
        
        if checkTextFieldEmpty([name,bankNumber]){
             self.performSegue(withIdentifier: pushInputPhone, sender: nil)
            return
        }
       
    }
     //MARK: 网络请求
    override func didRequest() {
        
//        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
//            //              self?.didRequestComplete(result)
//            return nil
//            }, error: errorBlockFunc())
        
    }
        

}
