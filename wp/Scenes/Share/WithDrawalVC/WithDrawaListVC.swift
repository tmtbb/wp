//
//  WithDrawaListVC.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 定义 WithDrawaListVCCell cell
class WithDrawaListVCCell: OEZTableViewCell {
    
    // 时间lb 
    @IBOutlet weak var minuteLb: UILabel!
    // 时间lb
    @IBOutlet weak var timeLb: UILabel!
    // 银行图片
    @IBOutlet weak var bankLogo: UIImageView!
    // 提现金额
    @IBOutlet weak var moneyLb: UILabel!
    //  提现至
    @IBOutlet weak var withDrawTo: UILabel!
    //  状态
    @IBOutlet weak var statusBtn: UIButton!
    //  状态
    @IBOutlet weak var statusLb: UILabel!
    // 刷新cell
    override func update(_ data: Any!) {
        let model : WithdrawModel = data as! WithdrawModel
        // 银行名称
        let bankName : String = model.bank as String
        // 提现至
        withDrawTo.text = "提现至" + "\(bankName)"
        moneyLb.text =   "\(model.amount)" 
        var status = String()
        let timesp : Int = Date.stringToTimeStamp(stringTime: model.withdrawTime)
        timeLb.text = Date.yt_convertDateStrWithTimestempWithSecond(timesp, format: "yyyy-MM-dd")
        minuteLb.text = Date.yt_convertDateStrWithTimestempWithSecond(timesp, format: "HH:mm:ss")
        
        status = model.status == 1 ? "处理中" :  (model.status == 2 ? "提现成功" : "提现失败")
        bankLogo.image = BankLogoColor.share().checkLocalBank(string: model.bank) ? UIImage.init(named: BankLogoColor.share().checkLocalBankImg(string: model.bank)) : UIImage.init(named: "unionPay")

        statusBtn.setTitle(status, for: UIControlState.normal)
    }
}
class WithDrawaListVC: BasePageListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现记录"
    }
    //  请求接口刷新数据
    override func didRequest(_ pageIndex : Int) {
        
        print(pageIndex)
        AppAPIHelper.user().withdrawlist(status: 0 , pos: Int32((pageIndex - 1) * 10 ), count: 10, complete: { [weak self](result) -> ()? in
            if let object = result {
                let Model : WithdrawListModel = object as! WithdrawListModel
                self?.didRequestComplete(Model.withdrawList as AnyObject?)
            }else{
                self?.didRequestComplete(nil)
            }
            return nil
            }, error: errorBlockFunc())
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let model = self.dataSource?[indexPath.row] as! WithdrawModel
        ShareModel.share().shareData["wid"] = "\(model.wid)"
        ShareModel.share().detailModel = model
        self.performSegue(withIdentifier: "PushWithDrawDetail", sender: nil)
        
        
    }
}
