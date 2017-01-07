//
//  RechargeListvc.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//OEZTableViewCell  UItableViewCell
class RechargeListVCCell: OEZTableViewCell {
    
    // 姓名Lb
    @IBOutlet weak var nameLb: UILabel!
    
    // 时间Lb
    @IBOutlet weak var timeLb: UILabel!
    
    // 充值金额Lb
    @IBOutlet weak var moneyCountLb: UILabel!
    
    // 状态Lb
    @IBOutlet weak var statusLb: UILabel!
    
    
    // 刷新cell
    override func update(_ data: Any!) {
        
        let model =  data as! RechargeListModel
        //打印输出 model.rid
        let  s =  String(format: "%x", model.rid)
        print(s)
        moneyCountLb.text = s;
        
        
    }
    
    
}

class RechargeListVC: BasePageListTableViewController {
    
    /**定义全局的数组装 model**/
    // var data :  RechargeListModel!
    
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值列表"
        
    }
    //测试充值列表
    override func didRequest(_ pageIndex : Int) {

        AppAPIHelper.user().creditlist(status: "", pos: 0, count: 10, complete: {[weak self] (result) -> ()? in
            self?.didRequestComplete(result)

            return nil
            
        }, error: errorBlockFunc())
        
    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//       
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
//        }
//        more.backgroundColor = UIColor.lightGray
//        
//        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
//            //
//        }
//        favorite.backgroundColor = UIColor.orange
        
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            
            print("1111")
        }
        
//        let newsahre = UITableViewRowActionz
        share.backgroundColor = UIColor.blue
        
        return [share]
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//     
//    }
   
    
   
}


