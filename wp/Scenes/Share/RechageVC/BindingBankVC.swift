//
//  BindingBankVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//银行卡视图 cell
class BindingBankVCCell: OEZTableViewCell {
    
}


class BindingBankVC: BaseListTableViewController {
    
    //添加银行卡
    @IBAction func addBank(_ sender: Any) {
        
        
                
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { [weak self](result) -> ()? in
            self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
    
    //实现银行卡左滑删除的代理
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
    
    
    
}
