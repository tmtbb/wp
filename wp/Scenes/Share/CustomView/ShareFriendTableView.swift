//
//  ShareFriendTableView.swift
//  wp
//
//  Created by sum on 2017/1/16.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
// 设置代理
protocol ShareCellDelegate: NSObjectProtocol {
    
    func cellBtnTapped(string : String)
}
class ShareVCCell: UITableViewCell {
    
    
 
    
    @IBOutlet weak var iconImage: UIImageView!            // 左边的图片
    @IBOutlet weak var userImage: UIImageView!            // 头像
    @IBOutlet weak var nameLabel: UILabel!                // 姓名
    @IBOutlet weak var typeLabel: UILabel!                // 类型
    @IBOutlet weak var timeLabel: UILabel!                // 时间
    @IBOutlet weak var benifityLabel: UILabel!           // 收益
    
    
  
}


class ShareFriendTableView: UITableView, UITableViewDelegate, UITableViewDataSource  {
    
    var cellDelegate: ShareCellDelegate?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        rowHeight = 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if let myDelegate = cellDelegate{
            
            myDelegate.cellBtnTapped(string: "1123")
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareVCCell")
        return cell!
    }
}
