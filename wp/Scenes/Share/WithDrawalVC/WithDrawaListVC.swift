//
//  WithDrawaListVC.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class WithDrawaListVCCell: UITableViewCell {
    
    //姓名lb
    @IBOutlet weak var nameLb: UILabel!
    
    //姓名lb
    @IBOutlet weak var timeLb: UILabel!
    
    //充值金额
    @IBOutlet weak var moneyCountLb: UILabel!
    
    //状态
    @IBOutlet weak var statusLb: UILabel!
    
    
    // 刷新cell
    func update(_ data: Any!) {
        
        
    }
    
}
class WithDrawaListVC: BasePageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func didRequest(_ pageIndex : Int) {
        
        AppAPIHelper.user().withdrawlist(status: "", pos: 0, count: 10, complete: { [weak self](result) -> ()? in
            
            self?.didRequestComplete(result)
            return nil
            }, error: errorBlockFunc())
        
    }

 
  

}
