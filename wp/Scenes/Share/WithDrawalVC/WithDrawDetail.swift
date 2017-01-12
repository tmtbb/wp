//
//  WithDrawDetail.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 提现详情
class WithDrawDetail: BaseTableViewController {
    
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
        
        title = "提现详情"
        didRequest()
        self.bankName.text =  ShareModel.share().detailModel.bank
         self.withDrawtime.text =  ShareModel.share().detailModel.bank
         self.expectTime.text =  ShareModel.share().detailModel.bank
        
         self.ToAccountTime.text =  ShareModel.share().detailModel.bank
    }
    
    // 请求接口
     override func didRequest() {
        //Int(string99)
        
        let wid : String = ShareModel.share().shareData["wid"]! as String
        
        AppAPIHelper.user().withdrawdetail(withdrawld: Int64(wid)!, complete: { [weak self](result) -> ()? in
            //                         self?.didRequestComplete(result)
            let model : WithdrawModel = result as! WithdrawModel
            
            self?.bankName.text = model.bank
            
            return nil
            }, error: errorBlockFunc())
        
    }
    
}
