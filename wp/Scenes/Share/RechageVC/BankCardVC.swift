//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class BindingBankVCCell: UITableViewCell {
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 银行名称
    @IBOutlet weak var cardNum: UILabel!
    
    
    // 刷新cell
     func update(_ data: Any!) {
        
        let model:BankListModel? = data as? BankListModel
//        print(model!.branchBank)
        bankName.text = model!.branchBank
    }
}
class BankCardVC: BaseListTableViewController {
    
     var dataArry : [BankListModel] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    override func didRequest() {
        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
            
            let Model : BankModel = result as! BankModel
            self?.didRequestComplete(Model.card as AnyObject)
            
                      self?.dataArry = Model.card!
//                     print( Model)
              self?.tableView.reloadData()
            return nil
            }, error: errorBlockFunc())
        
        
    }
    //MARK: 实现银行卡左滑删除的代理
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            
            
            //        let  model :BankModel = self.dataArry[indexPath.section] as BankModel
            
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : BindingBankVCCell = tableView.dequeueReusableCell(withIdentifier: "BankCardVCCell") as! BindingBankVCCell
        
        
        let  Model : BankListModel = self.dataArry[indexPath.section]
    
        cell.update(Model.self)
        return cell
        
    }
    
    
    
}
