//
//  RechargeVCTableView.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//
// 
import UIKit

class RechargeVcTableView: UITableView ,UITableViewDelegate, UITableViewDataSource{
    
    //设置选中的行数
    var selectNumber = Int()
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        selectNumber = 100000
        delegate = self
        dataSource = self
        rowHeight = 38
    }
    
    
    //MARK:-设置表的代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeVcCell", for: indexPath)
        cell.accessoryType =  UITableViewCellAccessoryType .none
        
        if indexPath.row == selectNumber {
            cell.accessoryType =  UITableViewCellAccessoryType .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        selectNumber = indexPath.row
        tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShareModel().selectType), object: NSNumber.init(value: indexPath.row), userInfo:nil)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        
    }
    
    
}
