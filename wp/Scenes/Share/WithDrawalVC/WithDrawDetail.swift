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
        
        //"提现详情"
        title = ShareModel.share().comeFromRechage ? "提现详情" : "充值详情"
        didRequest()
        bankName.text =  ShareModel.share().detailModel.bank
        withDrawtime.text = ShareModel.share().detailModel.withdrawTime
        expectTime.text = ShareModel.share().detailModel.expectTime

        ToAccountTime.text = ShareModel.share().detailModel.status == 1 ? "处理中"  :  (ShareModel.share().detailModel.status == 2 ? "提现成功" : "提现失败")
        
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
