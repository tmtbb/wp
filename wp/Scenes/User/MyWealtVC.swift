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
    
    
    var monthLb  : UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        
        title  = "我的资产"
        print("%f",NSStringFromCGRect(tableView.frame))
        tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-60)
        headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
        
        
        monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
        monthLb.text = "12 月"
        
        headerView.addSubview(monthLb)
        
        
        
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
        
        self.performSegue(withIdentifier: "PushToRechage", sender: nil )
    }
    
    @IBAction func withDraw(_ sender: Any) {
        //PushWithdraw
        
        self.performSegue(withIdentifier: "PushWithdraw", sender: nil )
    }
}
