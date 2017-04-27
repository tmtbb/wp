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
        typeBank.text = ShareModel.share().shareData["bankName"]
        title = "输入手机号"
    }
    
    @IBAction func addBank(_ sender: Any) {
        if checkTextFieldEmpty([typeBank,phone]){
            if isTelNumber(num: phone.text!) == false{
                ShareModel.share().shareData["phone"] =  phone.text!
                SVProgressHUD.showErrorMessage(ErrorMessage: "手机号格式错误", ForDuration: 1, completion: nil)
                return
            }
            ShareModel.share().shareData["phone"] =  phone.text!
            let param = BingCardParam()
            param.bankId = Int(ShareModel.share().shareData["bankId"]!)!
            param.branchBank = ShareModel.share().shareData["branchBank"]!
            param.cardNO = ShareModel.share().shareData["cardNo"]!
            param.name = ShareModel.share().shareData["name"]!
            param.bankName = typeBank.text!
            AppAPIHelper.user().bingcard(param: param, complete: { (result) -> ()? in
                if result != nil {
                    //let  bankId : Int = object["bankId"] as! Int

                    SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 1, completion: {
                        [weak self] in
                        for  nav : UIViewController in (self?.navigationController?.viewControllers)! {
                            if nav.isKind(of: BankCardVC.self){
                                _ = self?.navigationController?.popToViewController(nav, animated: true)
                            }
                            if nav.isKind(of: WithDrawalVC.self){
                                _ = self?.navigationController?.popToViewController(nav, animated: true)
                            }
                        }
                    })
                }
                return nil
            }, error: errorBlockFunc())
            
//            AppAPIHelper.user().bingcard(bank: Int64(ShareModel.share().shareData["bankId"]!)!, branchBank: ShareModel.share().shareData["branchBank"]!, cardNo: ShareModel.share().shareData["cardNo"]!, name: ShareModel.share().shareData["name"]!, bankName: typeBank.text!,complete: { (result) -> ()? in
//                
//                if result != nil {
//                    //let  bankId : Int = object["bankId"] as! Int
//                    SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 1, completion: {
//                        [weak self] in
//                        for  nav : UIViewController in (self?.navigationController?.viewControllers)! {
//                            
//                            if nav.isKind(of: BankCardVC.self){
//                                
//                                
//                                _ = self?.navigationController?.popToViewController(nav, animated: true)
//                            }
//                            if nav.isKind(of: WithDrawalVC.self){
//                                
//                                _ = self?.navigationController?.popToViewController(nav, animated: true)
//                            }
//                            
//                        }
//                    })
//                    
//                    
//                    
//                }
//                return nil
//            }, error: errorBlockFunc())
            
            return
        }
        
    }
    
    
    
}
