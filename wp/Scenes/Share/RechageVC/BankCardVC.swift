//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class BindingBankVCCell: OEZTableViewCell {
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 银行名称
    @IBOutlet weak var cardNum: UILabel!
    
    //
    //    var  Model = BankModel()
    // 刷新cell
    override func update(_ data: Any!) {
        
        print(data)
    }
}
class BankCardVC: BaseListTableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }
    override func didRequest() {
        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
            
            let Model : BankListModel = result as! BankListModel
//            self?.didRequestComplete(Model.cardlist as AnyObject)
            
//            self?.dataArry = Model.cardlist!
            print( Model)
//            self?.tableView.reloadData()
            return nil
            }, error: errorBlockFunc())
        
        
    }

  

}
