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
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
     // 银行名称
    @IBOutlet weak var cardNum: UILabel!
    // 刷新cell
    override func update(_ data: Any!) {
        
        let model : BankModel = data as! BankModel
        
        bankName.text = model.name
        
        cardNum.text = "\(model.cardId)"
        
        
    }
}


class BankCardVC: BaseListTableViewController {
    
    
    var dataArry = [BankModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的银行卡"
        
    }
    
    //MARK:  网络请求
    override func didRequest() {
        
//        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
//            
//            
//            
//            let Model : BankListModel = result as! BankListModel
//            self?.didRequestComplete(Model.cardlist as AnyObject)
//            
//            self?.dataArry = Model.cardlist!
//            self?.tableView.reloadData()
//            return nil
//            }, error: errorBlockFunc())
        
    }
    //MARK:  添加银行卡
    @IBAction func addBank(_ sender: Any) {
        
        self.performSegue(withIdentifier: pushFullbankInformation, sender: nil)
        
        
    }
    
    //MARK: 实现银行卡左滑删除的代理
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            
            
            let  model :BankModel = self.dataArry[indexPath.section] as BankModel
            
//          APISocketHelper.us
            
        }
        share.backgroundColor = UIColor.red
        
        return [share]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArry.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 15
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}
