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

        navLeftBtn()
        title = "提现状态"
         let index = ShareModel.share().detailModel.cardNo.index(ShareModel.share().detailModel.cardNo.startIndex, offsetBy: ShareModel.share().detailModel.cardNo.length() - 4)
        self.bankName.text = ShareModel.share().detailModel.bank + " ( " +  ShareModel.share().detailModel.cardNo.substring(from: index) + " )"
        let amount : Double =  ShareModel.share().detailModel.amount
        moneyAccount.text = String.init(format: "%.2f", amount)
        self.status.text! = ShareModel.share().detailModel.status == 1 ? "处理中" :  (ShareModel.share().detailModel.status == 2 ? "提现成功" : "提现失败")
       bankLogo.image = BankLogoColor.share().checkLocalBank(string: ShareModel.share().detailModel.bank) ? UIImage.init(named: BankLogoColor.share().checkLocalBankImg(string: ShareModel.share().detailModel.bank)) : UIImage.init(named: "unionPay")

    }
    
    
     func navLeftBtn(){
    
        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        
        btn.setTitle("", for: UIControlState.normal)
        
        btn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal )
        
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        
        btn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barItem
        }
    func popself(){
     let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    // 请求接口
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
   

}
