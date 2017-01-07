//
//  SuccessWithdrawVC.swift
//  wp
//
//  Created by sum on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class SuccessWithdrawVC: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "提现成功"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }
   

}
