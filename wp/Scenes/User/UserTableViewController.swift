//
//  UserTableViewController.swift
//  wp
//
//  Created by macbook air on 16/12/22.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SideMenuController
import DKNightVersion
class UserTableViewController: BaseTableViewController {
    //用户名
    @IBOutlet weak var nameLabel: UILabel!
    //总单数
    @IBOutlet weak var propertyNumber: UILabel!
    @IBOutlet weak var yuanLabel: UILabel!
    //总手数
    @IBOutlet weak var integralLabel: UILabel!
    @IBOutlet weak var fenLabel: UILabel!
    //退出登录
    @IBOutlet weak var logoutButton: UIButton!
    //资金按钮
    @IBOutlet weak var myPropertyBtn: UIButton!
    //个人cell的背景颜色
    @IBOutlet weak var personBackgroud: UIView!
    @IBOutlet weak var propertyBackgroud: UIView!
    @IBOutlet weak var integralBackground: UIView!
    @IBOutlet weak var memberImageView: UIImageView!
    
    lazy var numberFormatter:NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let jumpNotifyDict = [1 : AppConst.NotifyDefine.jumpToDealList,
                          2 : AppConst.NotifyDefine.jumpToWithdraw,
                          3 : AppConst.NotifyDefine.jumpToRecharge,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //用户余额数据请求
        UserModel.share().addObserver(self, forKeyPath: AppConst.KVOKey.balance.rawValue, options: .new, context: nil)
        registerNotify()
        //更新token
        AppDataHelper.instance().checkTokenLogin()
        requstTotalHistroy()
        initUI()
    }
    func initUI() {
        tableView.contentSize = CGSize(width: 0, height: 600.0)
        tableView.backgroundColor = UIColor(hexString: "#F5F5F5")
        personBackgroud.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        propertyBackgroud.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)
        integralBackground.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)
        logoutButton.layer.borderWidth = 0.7
        logoutButton.layer.borderColor = UIColor(hexString: "#cccccc").cgColor
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == AppConst.KVOKey.balance.rawValue {
            guard UserModel.share().currentUser != nil else { return }
            nameLabel.text = formatMoneyString(balance: (UserModel.share().currentUser?.balance)! )
            nameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    func formatMoneyString(balance:Double) -> String? {
       let str = numberFormatter.string(from: NSNumber(value: balance))
        return str?.components(separatedBy: "￥").last?.components(separatedBy: "¥").last?.components(separatedBy: "$").last
    }
    
    func requstTotalHistroy() {
        AppAPIHelper.user().getTotalHistoryData(complete: { [weak self](result) -> ()? in
            if let model = result as? TotalHistoryModel {
                self?.propertyNumber.text = "\(model.amount)"
                self?.integralLabel.text = "\(model.count)"
            }
            return nil
        }, error: errorBlockFunc())
    }
    //MARK: -- 添加通知
    func registerNotify() {
        let notificationCenter = NotificationCenter.default
        //登录成功
        notificationCenter.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //登录成功
    func updateUI()  {
        memberImageView.isHidden = UserModel.share().getCurrentUser()?.type == 0
    }
    //退出登录
    @IBAction func logout(_ sender: Any) {
        AppDataHelper.instance().clearUserInfo()
        sideMenuController?.toggle()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row > 3{
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jumpNotifyDict[indexPath.row]!), object: nil, userInfo: nil)
        sideMenuController?.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    deinit {
        UserModel.share().currentUser?.removeObserver(self, forKeyPath: "balance")
        NotificationCenter.default.removeObserver(self)
    }
    
}
