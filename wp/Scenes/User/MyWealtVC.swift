//
//  MyWealtVC.swift
//  wp
//
//  Created by sum on 2017/1/7.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class MyWealtVCCell: UITableViewCell {
    @IBOutlet weak var LB: UILabel!
    
}
class MyWealtVC: BaseListTableViewController {
    var headerView : UIView = UIView()
    
    // 提现按钮
    @IBOutlet weak var withDraw: UIButton!
    
    // 充值按钮
    @IBOutlet weak var recharge: UIButton!
    
    var monthLb  : UILabel = UILabel()
    
    @IBOutlet weak var account: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        didRequest()
        title  = "我的资产"
        print("%f",NSStringFromCGRect(tableView.frame))
        
        
        
        
    }
    //userInfo
      override func didRequest() {
        didRequestComplete([] as AnyObject)
       //errorBlockFunc
        
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
            
            
            if let object = result {
            
                let  money : NSNumber =  object["balance"] as! NSNumber
                self?.account.text =  "\(money)"
            }
            
            return nil
        }, error: errorBlockFunc())
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.view.frame.size.height-131-50
        
        
    }
    
    @IBAction func recharge(_ sender: Any) {
        
        recharge.isSelected = true
        withDraw.isSelected = false
        self.performSegue(withIdentifier: "PushToRechage", sender: nil )
    }
    
    @IBAction func withDraw(_ sender: Any) {
        
        recharge.isSelected = false
        withDraw.isSelected = true
        self.performSegue(withIdentifier: "PushWithdraw", sender: nil )
    }
    
    
}
