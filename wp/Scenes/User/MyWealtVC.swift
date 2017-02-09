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
    
    //  提现按钮
    @IBOutlet weak var withDraw: UIButton!
    //  充值按钮
    @IBOutlet weak var recharge: UIButton!
    //  月份label
    var monthLb  : UILabel = UILabel()
    //  账户余额
    @IBOutlet weak var account: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        didRequest()
        title  = "我的资产"
        let int : Double = Double((UserModel.getCurrentUser()?.balance)!)
        let str : String = NSString(format: "%.2f" ,int) as String
        account.text =  "\(str)"
    }
    //MARK: 进入界面加载请求方法 保证数据的最新性
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: false)
        hideTabBarWithAnimationDuration()
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
            if let object = result {
                let  money : NSNumber =  object["balance"] as! NSNumber
                let floatmonet : Float = Float.init(money)
                let str : String = NSString(format: "%.2f" ,floatmonet) as String
                self?.account.text =  "\(str)"
                UserModel.updateUser(info: { (result) -> ()? in
                    UserModel.getCurrentUser()?.balance = Double(money)
                    ShareModel.share().useMoney = Double(money)
                    return nil
                })
            }
            return nil
            }, error: errorBlockFunc())
    }
    //MARK: 界面销毁删除监听机制
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    //MARK: 网络请求
    override func didRequest(_ pageIndex : Int) {
        didRequestComplete(["","","","","","","","","","","","","","","","","","","","",""] as AnyObject)
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
               if let object = result {
                let  money : NSNumber =  object["balance"] as! NSNumber
                let floatmonet : Float = Float.init(money)
                let str : String = NSString(format: "%.2f" ,floatmonet) as String
                self?.account.text =  "\(str)"
                UserModel.updateUser(info: { (result) -> ()? in
                    UserModel.getCurrentUser()?.balance = Double(money)
                    return nil
                })
            }
            return nil
            }, error: errorBlockFunc())
        
    }
    //MARK: tableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWealtVCCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
    }
    //MARK: 充值按钮的点击事件
    @IBAction func recharge(_ sender: Any) {
        recharge.isSelected = true
        withDraw.isSelected = false
        self.performSegue(withIdentifier: "PushToRechage", sender: nil )
    }
    //MARK: 提现按钮的点击事件
    @IBAction func withDraw(_ sender: Any) {
        recharge.isSelected = false
        withDraw.isSelected = true
        self.performSegue(withIdentifier: "PushWithdraw", sender: nil )
    }
  
}
