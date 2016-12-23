//
//  UserTableViewController.swift
//  wp
//
//  Created by macbook air on 16/12/22.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SideMenuController
class UserTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      tableView.backgroundColor = UIColor.orange
      tableView.separatorColor = UIColor.white
        tableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        if section == 1 {
           
            return 5
        }
        else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section =  indexPath.section
        switch section {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyMessage), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("个人资料")
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyAttention), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的关注")
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyPush), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的推单")
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyBask), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的晒单")
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToFeedback), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("交易明细")
        case 5:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToFeedback), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("意见反馈")
        case 6:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToProductGrade), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("产品评分")
        case 7:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToAttentionUs), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("关注我们")
        default: break
        }
    }
    
   
}
