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
        //        let dataModel = data as! RechargeListModel
        
        //        print(dataModel.id)
        //        nameLb.text =  "\(dataModel.id)"
        //    }
        
        
    }
    
}

class RechargeListVC: BasePageListTableViewController {
    
    /**定义全局的数组装 model**/
    var dataArry : [RechargeListModel]!
    
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //测试充值列表
    override func didRequest(_ pageIndex : Int) {
        
        AppAPIHelper.user().creditlist(status: "", pos: 0, count: 10, complete: { (result) -> ()? in
            
            //            self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
}


