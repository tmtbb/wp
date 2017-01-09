//
//  RechargeVCTableView.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class RechargeVcTableView: UITableView ,UITableViewDelegate, UITableViewDataSource{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        rowHeight = 44
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeVcCell", for: indexPath)
        
//        cell.accessoryType =  UITableViewCellAccessoryType .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cell :UITableViewCell = tableView.cellForRow(at:indexPath )!
        
        
        
          cell.accessoryType =  UITableViewCellAccessoryType .checkmark
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShareModel().selectType), object: NSNumber.init(value: indexPath.row), userInfo:nil)
    }
    
}
