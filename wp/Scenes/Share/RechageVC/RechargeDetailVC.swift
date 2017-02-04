//
//  WithDrawDetail.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 提现详情
class RechargeDetailVC: BaseTableViewController {
    
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 提现时间
    @IBOutlet weak var withDrawtime: UILabel!
    // 预计到账时间
    @IBOutlet weak var expectTime: UILabel!
    // 到账时间
    @IBOutlet weak var ToAccountTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值详情"
        didRequest()
    }
    
    // 请求接口
    override func didRequest() {
        
        
   
        
        AppAPIHelper.user().creditdetail(rid:Int64(ShareModel.share().shareData["wid"]!)!, complete: { [weak self](result) -> ()? in
            //                         self?.didRequestComplete(result)
            let model : WithdrawModel = result as! WithdrawModel
            
            self?.bankName.text = model.bank
            
            return nil
            }, error: errorBlockFunc())
        
    }
    
}
