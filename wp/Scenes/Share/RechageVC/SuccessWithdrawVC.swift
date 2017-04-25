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
        let amount : Double =  Double(ShareModel.share().withdrawResultModel.balance)
        moneyAccount.text = String.init(format: "%.2f", UserModel.share().currentUser!.balance - amount)
        self.status.text! = "提现成功"
       bankLogo.image = BankLogoColor.share().checkLocalBank(string: ShareModel.share().detailModel.bank) ? UIImage.init(named: BankLogoColor.share().checkLocalBankImg(string: ShareModel.share().detailModel.bank)) : UIImage.init(named: "unionPay")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
     func navLeftBtn(){
    
        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        
        btn.setTitle("", for: UIControlState.normal)
        
        btn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal )
        
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        
        btn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barItem
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
    }
    func popself(){
     let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    // 请求接口
    override func didRequest() {
        let param = RechargeDetailParam()
        AppAPIHelper.user().creditdetail(param: param, complete: { (result) -> ()? in
            
            return nil
        }, error: errorBlockFunc())
        
    }
   

}
