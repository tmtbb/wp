//
//  SuccessWithdrawVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class SuccessWithdrawVC: BaseTableViewController {

    
      @IBOutlet weak var bankLogo: UIImageView!
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    
    // 提现金额
    @IBOutlet weak var moneyAccount: UILabel!
    
    // 状态
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "提现状态"
        self.bankName.text = ShareModel.share().detailModel.bank
        let amount : Double =  ShareModel.share().detailModel.amount
        moneyAccount.text = "\(amount) 元"
        
//        var status = String()
//        
//        if  ShareModel.share().detailModel.status == 1 {
//            status = "处理中"
//        } else if ShareModel.share().detailModel.status == 2 {
//            status = "成功"
//        }else if ShareModel.share().detailModel.status == -1{
//             status = "余额不足"
//        }
//        else{
//            status = "失败"
//        }
        
          bankLogo.image = BankLogoColor.share().checkLocalBank(string: ShareModel.share().detailModel.bank) ? UIImage.init(named: BankLogoColor.share().checkLocalBankImg(string:ShareModel.share().detailModel.bank)) : UIImage.init(named: "unionPay")
        self.status.text! = ShareModel.share().detailModel.status == 1 ? "处理中" :  (ShareModel.share().detailModel.status == 2 ? "提现成功" : "提现失败")
       

    }

   
    // 请求接口
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
   

}
