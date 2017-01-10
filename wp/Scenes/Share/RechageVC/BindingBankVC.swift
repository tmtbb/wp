//
//  BindingBankVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//进入下个界面的
let pushFullbankInformation:String = "pushFullbankInformation"
//pushInputPhone
//银行卡视图 cell
class BindingBankVCCell: OEZTableViewCell {
    
}


class BindingBankVC: BaseListTableViewController {
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "绑定银行卡"
        
    }
    
    //MARK:  网络请求
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { [weak self](result) -> ()? in
            self?.didRequestComplete(["",""] as AnyObject)
            return nil
        }, error: errorBlockFunc())
        
    }
    //MARK:  添加银行卡
    @IBAction func addBank(_ sender: Any) {
        
        self.performSegue(withIdentifier: pushFullbankInformation, sender: nil)
        
        
    }

    //MARK: 实现银行卡左滑删除的代理
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
