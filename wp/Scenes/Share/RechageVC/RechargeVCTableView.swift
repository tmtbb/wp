//
//  RechargeVCTableView.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//
//
import UIKit
class RechargeCell: UITableViewCell {
    
    @IBOutlet weak var bankNumber: UILabel!
}
class RechargeVcTableView: UITableView ,UITableViewDelegate, UITableViewDataSource{
    
    //设置选中的行数
    var selectNumber = Int()
    var dataArry : [BankListModel] = []
    dynamic var selectType : String = " "
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        selectNumber = 100000
        delegate = self
        dataSource = self
        rowHeight = 38
        didRequest()
    }
    func didRequest() {
        
        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
            
            
            if let object = result {
                
                let Model : BankModel = object as! BankModel
                
                self?.dataArry = Model.cardlist! as [BankListModel]
                
                self?.reloadData()
                
            }
            return nil
            }, error: nil)
        
    }
    //MARK:-设置表的代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArry.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RechargeCell = tableView.dequeueReusableCell(withIdentifier: "RechargeCell", for: indexPath) as! RechargeCell
        cell.accessoryType =  UITableViewCellAccessoryType .none
        let model : BankListModel =  self.dataArry[indexPath.row]
        
        cell.bankNumber.text! = model.cardNo
        if indexPath.row == selectNumber {
            cell.accessoryType =  UITableViewCellAccessoryType .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        selectNumber = indexPath.row
        tableView.reloadData()
        selectType = "\(indexPath.row)"
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        
    }
    
    
}
