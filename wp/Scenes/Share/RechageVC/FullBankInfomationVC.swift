//
//  FullBankInfomationVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
//进入输入手机号界面
let pushInputPhone:String = "pushInputPhone"
//pushInputPhone
class FullBankInfomationVC: BaseTableViewController {
    
    
    
    // 银行卡号
    @IBOutlet weak var bankNumber: UITextField!
    // 支行地址
    @IBOutlet weak var branceAddress: UITextField!
    // 持卡人姓名
    @IBOutlet weak var name: UITextField!
    
    
    
    override func viewDidLoad() {
        
        title = "输入银行卡信息"
        
        super.viewDidLoad()
        
        
    }
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    @IBAction func nextInputPhone(_ sender: Any) {
        
        
        if checkTextFieldEmpty([name,bankNumber,branceAddress]){
            
            if !onlyInputTheNumber(bankNumber.text!) {
             SVProgressHUD.showErrorMessage(ErrorMessage: "输入正确的银行卡号", ForDuration: 1, completion: {})
                return
            }
            didRequest()
            return
        }
    }
    //MARK: 网络请求
    override func didRequest() {
        
        
        AppAPIHelper.user().getBankName(withbankld:bankNumber.text!, complete: { [weak self](result) -> ()? in
            
            if let object = result{
              let  bankId : Int = object["bankId"] as! Int
                ShareModel.share().shareData["cardNo"] = (self?.bankNumber.text!)!
                ShareModel.share().shareData["branchBank"] = (self?.branceAddress.text!)!
                ShareModel.share().shareData["name"] = (self?.name.text!)!
                ShareModel.share().shareData["bankName"] = object["bankName"] as? String
                ShareModel.share().shareData["bankId"] = "\(bankId)"
                self?.performSegue(withIdentifier: pushInputPhone, sender: nil)
            }
            return nil
            }, error: errorBlockFunc())
        
    }
    func onlyInputTheNumber(_ string: String) -> Bool {
        let numString = "[0-9]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", numString)
        let number = predicate.evaluate(with: string)
        return number
    }
    
}
