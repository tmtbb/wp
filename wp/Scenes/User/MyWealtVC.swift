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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        
        title  = "我的资产"
        print("%f",NSStringFromCGRect(tableView.frame))
        
        
        
        
    }
    override func didRequest() {
        didRequestComplete([] as AnyObject)
        //
        //        //注释掉  请求接口有的时候再打开
        //        //        AppAPIHelper.share().getShareData(userId: "123", phone: "15306559323", selectIndex: "1223", pageNumber: "0", complete: { (result ) -> ()? in
        //        //
        //        //            return nil
        //        //        }, error: errorBlockFunc())
        //        //        print(errorBlockFunc)
        //
        //
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
