//
//  RechargeListvc.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class RechargeListVCCell: UITableViewCell {
    
    //姓名lb
    @IBOutlet weak var nameLb: UILabel!
    
    //姓名lb
    @IBOutlet weak var timeLb: UILabel!
    
    //充值金额
    @IBOutlet weak var moneyCountLb: UILabel!
    
    //状态
    @IBOutlet weak var statusLb: UILabel!
    
    
    // 刷新cell
    func update(_ data: Any!) {
        
        let model =  data as! RechargeListModel
        
        let  s =  String(format: "%x", model.rid)
        
        moneyCountLb.text = s;
        
        
    }
    
}

class RechargeListVC: BasePageListTableViewController {
    
    /**定义全局的数组装 model**/
    var data :  RechargeListModel!
    
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值列表"
        
    }
    //测试充值列表
    override func didRequest(_ pageIndex : Int) {
        
        AppAPIHelper.user().creditlist(status: "", pos: 0, count: 10, complete: { [weak self](result) -> ()? in
            
            self?.data  =  result as! RechargeListModel!
            
            self?.didRequestComplete(self?.data.depositsinfo as AnyObject?)
            
            return nil
            
            }, error: errorBlockFunc())
        
    }
}


