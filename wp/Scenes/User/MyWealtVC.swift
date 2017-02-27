//
//  MyWealtVC.swift
//  wp
//
//  Created by sum on 2017/1/17.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
class MyWealtVCCell: OEZTableViewCell {
    
}
class MyWealtVC: BaseCustomPageListTableViewController {
    //头部背景
    @IBOutlet weak var headBg: UIView!
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
        headBg.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
//        didRequest()
        title  = "我的资产"
        recharge.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        recharge.layer.cornerRadius = 5
        recharge.clipsToBounds = true
       
    }
    //MARK: --界面加载请求方法 保证数据的最新性
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: false)
        hideTabBarWithAnimationDuration()
        didRequest()
    }
    //MARK: --界面销毁删除监听机制
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    //MARK: --网络请求
    override func didRequest(_ pageIndex : Int) {
    didRequestComplete(["","",""] as AnyObject)
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
            if let object = result {
                let  money : Double =  object["balance"] as! Double
                let floatmonet : Double = Double.init(money)
                let str : String = NSString(format: "%.2f" ,floatmonet) as String
                self?.account.text =  "\(str)"
 
                ShareModel.share().useMoney = money
                UserModel.updateUser(info: { (result) -> ()? in
                    UserModel.share().getCurrentUser()?.balance = Double(money)
                    return nil
                })
            }
            return nil
            }, error: errorBlockFunc())
        
    }
    //MARK: --tableView delegate
//    override func numberOfSections(in tableView: UITableView) -> Int{
//        return 2
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
//        return 0.1
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//         return 38
//         return 65
       return 93
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWealtVCCell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerView  : UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
        
        headerView.backgroundColor = UIColor.groupTableViewBackground
        
        monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
        if section==0 {
            monthLb.text = "收益情况"
        }else{
            monthLb.text = "昨日收益"
        }
        monthLb.textColor = UIColor.init(hexString: "333333")
        monthLb.font = UIFont.systemFont(ofSize: 16)
        
        headerView.addSubview(monthLb)
        
        return headerView
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
//        
//        return 40
//    }
    //MARK: --充值按钮的点击事件
    @IBAction func recharge(_ sender: Any) {
        recharge.isSelected = true
        withDraw.isSelected = false
        self.performSegue(withIdentifier: "PushToRechage", sender: nil )
    }
    //MARK: --提现按钮的点击事件
    @IBAction func withDraw(_ sender: Any) {
        recharge.isSelected = false
        withDraw.isSelected = true
        self.performSegue(withIdentifier: "PushWithdraw", sender: nil )
    }
    
    
}
