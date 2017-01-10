//
//  BindingBankVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//  进入下个界面的key
let pushFullbankInformation:String = "pushFullbankInformation"
//银行卡视图 cell
class BindingBankVCCell: OEZTableViewCell {
    
    // 刷新cell
    override func update(_ data: Any!) {
        
        
    }
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
        
        
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            
            
        }
        share.backgroundColor = UIColor.red
        
        return [share]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 15
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : BindingBankVCCell = tableView.dequeueReusableCell(withIdentifier: "BindingBankVCCell") as! BindingBankVCCell
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}
