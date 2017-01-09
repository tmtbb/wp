//
//  SuccessChargeVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class SuccessChargeVC: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "充值成功"
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
      
    }
    
    //MARK: --网络请求
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }

}
