//
//  SuccessWithdrawVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class SuccessWithdrawVC: BaseTableViewController {

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
        
        let amount : Double =  ShareModel.share().detailModel.amount as! Double
        moneyAccount.text = "\(amount)"
        
        var status = String()
        
        if  ShareModel.share().detailModel.status == 1 {
            status = "处理中"
        } else if ShareModel.share().detailModel.status == 1 {
            status = "成功"
        }else{
            status = "失败"
        }
        self.status.text! = status

    }

   
    // 请求接口
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
   

}
