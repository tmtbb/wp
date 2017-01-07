//
//  WithDrawalVC.swift
//  wp
//
//  Created by sum on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class WithDrawalVC: BasePageListTableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        title = "提现"
        
        
    }
    override func didRequest(_ pageIndex : Int) {
        super.didRequestComplete([""] as AnyObject)
    
//
    }
   

}
