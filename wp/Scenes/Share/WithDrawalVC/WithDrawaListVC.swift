//
//  WithDrawaListVC.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class WithDrawaListVCCell: UITableViewCell {
    
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
    //状态
    @IBOutlet weak var statusBtn: UIButton!
    
    //状态
    @IBOutlet weak var statusLb: UILabel!
    
    
    // 刷新cell
    func update(_ data: Any!) {
        
        
    }
    
}
class WithDrawaListVC: BasePageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "提现记录"
        
    }
    
    override func didRequest(_ pageIndex : Int) {
        
        AppAPIHelper.user().withdrawlist(status: "", pos: 0, count: 10, complete: { [weak self](result) -> ()? in
            
            self?.didRequestComplete(["",""] as AnyObject?)
            return nil
            }, error: errorBlockFunc())
        
    }  

}
