//
//  MyWealtVC.swift
//  wp
//
//  Created by sum on 2017/1/17.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class MyWealtVCCell: OEZTableViewCell {
    
}
class MyWealtVC: BaseCustomPageListTableViewController {
    
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
        
        let int : Double = Double((UserModel.getCurrentUser()?.balance)!)
        
        account.text =  "\(int)"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        translucent(clear: false)
        hideTabBarWithAnimationDuration()
        
    }
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    override func didRequest(_ pageIndex : Int) {
        didRequestComplete([""] as AnyObject)
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
            
            
            if let object = result {
                
                let  money : NSNumber =  object["balance"] as! NSNumber
                
                ShareModel.share().shareData["balance"] = "\(money)"
                
                self?.account.text =  "\(money)"
                
                UserModel.updateUser(info: { (result) -> ()? in
                    
                    UserModel.getCurrentUser()?.balance = Double(money)
                    return nil
                })
//                UserModel.getCurrentUser()?.balance = Double(money)
                
            }
            
            return nil
            }, error: errorBlockFunc())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
//        
//        return 40
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWealtVCCell", for: indexPath)
        
        
        return cell
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
    //MARK: tableView delegate
    
    
    
    
    
}
