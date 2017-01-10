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

    // 自动识别
    @IBOutlet weak var AutomaticFd: UITextField!
    
    // 银行预留手机号
    @IBOutlet weak var phone: UITextField!
    
    
    
    override func viewDidLoad() {
        
        title = "输入银行卡信息"
        
        super.viewDidLoad()

      
    }
    @IBAction func nextInputPhone(_ sender: Any) {
        
        self.performSegue(withIdentifier: pushInputPhone, sender: nil)
    }
     //MARK: 网络请求
    override func didRequest() {
        
//        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
//            //              self?.didRequestComplete(result)
//            return nil
//            }, error: errorBlockFunc())
        
    }
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 2
    }
    

}
