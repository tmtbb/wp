//
//  SuccessChargeVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class SuccessChargeVC: BaseTableViewController {
    
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 金额
    @IBOutlet weak var account: UILabel!
    // 状态
    @IBOutlet weak var status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值成功"
    }
    //MARK: --网络请求
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
    
}
