//
//  DealDetailTableVC.swift
//  wp
//
//  Created by macbook air on 17/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class DealDetailTableVC: BaseTableViewController{

    //交易类型
    @IBOutlet weak var dealType: UILabel!
    //交易品种
    @IBOutlet weak var dealProduct: UILabel!
    //交易时间
    @IBOutlet weak var dealTime: UILabel!
    //交易金额
    @IBOutlet weak var dealMoney: UILabel!
    //最底履约保证金
    @IBOutlet weak var cashDeposit: UILabel!
    //手续费率
    @IBOutlet weak var poundage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
    


}
