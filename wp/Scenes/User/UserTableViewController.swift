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
    //头像
    @IBOutlet weak var iconImage: UIImageView!
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
    //登录
    @IBOutlet weak var loginBtn: UIButton!
    //注册
    @IBOutlet weak var register: UIButton!
    //跳转按钮
    @IBOutlet weak var pushBtn: UIButton!
    //资金按钮
    @IBOutlet weak var myPropertyBtn: UIButton!
    //个人cell的背景颜色
    @IBOutlet weak var personBackgroud: UIView!
    @IBOutlet weak var propertyBackgroud: UIView!
    @IBOutlet weak var integralBackground: UIView!
    @IBOutlet weak var integralButton: UIButton!
    
    @IBOutlet weak var memberImageView: UIImageView!
    
    lazy var numberFormatter:NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let jumpNotifyDict = [1 : AppConst.NotifyDefine.jumpToDeal,
                          2 : AppConst.NotifyDefine.jumpToWithdraw,
                          3 : AppConst.NotifyDefine.jumpToRecharge,
                          4 : AppConst.NotifyDefine.jumpToFeedback,
                          5 : AppConst.NotifyDefine.jumpToMyMessage,
                          6 : AppConst.NotifyDefine.jumpToMyAttention,
                          7 : AppConst.NotifyDefine.jumpToMyWealtVC,
                          8 : AppConst.NotifyDefine.jumpToAttentionUs]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentSize = CGSize(width: 0, height: 600.0)
        tableView.backgroundColor = UIColor(hexString: "#F5F5F5")
        personBackgroud.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        propertyBackgroud.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)
        integralBackground.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)
            loginBtn.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.auxiliary), for: .normal)
        register.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.auxiliary), for: .normal)
        logoutButton.layer.borderWidth = 0.7
        logoutButton.layer.borderColor = UIColor(hexString: "#cccccc").cgColor
        registerNotify()
        //更新token
        AppDataHelper.instance().checkTokenLogin()

        requstTotalHistroy()
        initReceiveBalanceBlock()
        if checkLogin() {
            loginSuccessIs(bool: true)
            memberImageView.isHidden = UserModel.share().getCurrentUser()?.type == 0
            if UserModel.share().getCurrentUser() == nil {
                memberImageView.isHidden = true
            }
            guard UserModel.share().currentUser != nil else {return}
            nameLabel.text = formatMoneyString(balance: UserModel.share().currentUser!.balance)
            if UserModel.share().getCurrentUser()!.balance > 999999.0 {
                nameLabel.adjustsFontSizeToFitWidth = true
            }
            
//            nameLabel.text = "\(UserModel.share().getCurrentUser()?.balance)"
// >>>>>>> master
//            if ((UserModel.share().getCurrentUser()?.avatarLarge) != "" && UserModel.share().getCurrentUser()?.avatarLarge == "default-head"){
//                iconImage.image = UIImage(named: (UserModel.share().getCurrentUser()?.avatarLarge) ?? "")
//                iconImage.image = UIImage(named: "default-head")
//            }
//            else{
//                iconImage.image = UIImage(named: "default-head")
//            }
//            
//            if ((UserModel.share().getCurrentUser()?.screenName) != "") {
//                nameLabel.text = UserModel.share().getCurrentUser()?.screenName
//                nameLabel.sizeToFit()
//            }
//            else{
//                nameLabel.text = "---"
//            }
        }  else{
            loginSuccessIs(bool: false)
            tableView.isScrollEnabled = false
        }
        
      
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == AppConst.KVOKey.balance.rawValue {
            guard UserModel.share().currentUser != nil else { return }
//            setBalanceText(balance: (UserModel.share().currentUser?.balance)!)
            nameLabel.text = formatMoneyString(balance: (UserModel.share().currentUser?.balance)! )
            nameLabel.adjustsFontSizeToFitWidth = true

        }
        
    }
    
    func formatMoneyString(balance:Double) -> String? {
       let str = numberFormatter.string(from: NSNumber(value: balance))
        return str?.components(separatedBy: "￥").last?.components(separatedBy: "¥").last?.components(separatedBy: "$").last
    }
    
    func setBalanceText(balance:Double) {
        nameLabel.text = formatMoneyString(balance: balance)
        if balance > 999999.0 {
            nameLabel.adjustsFontSizeToFitWidth = true
        }
        ShareModel.share().userMoney = balance
        DispatchQueue.main.async {
            UserModel.updateUser(info: { (result)-> ()? in
                UserModel.share().currentUser?.balance = balance
            })
        }
    }
    

    func initReceiveBalanceBlock() {
        SocketRequestManage.shared.receiveBalanceBlock = { (response) in
            let jsonResponse = response as! SocketJsonResponse
            let json = jsonResponse.responseJsonObject()
            if let result = json as? Dictionary<String,Any> {
                if let balance = result["balance"] as? Double {
                    self.setBalanceText(balance: balance)
                }
            }
            return nil
        }
        
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
        //退出登录
        notificationCenter.addObserver(self, selector: #selector(quitEnterClick), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.QuitEnterClick), object: nil)
        //登录成功
        notificationCenter.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
        //修改个人信息
        notificationCenter.addObserver(self, selector: #selector(changeUserinfo), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.ChangeUserinfo), object: nil)
        
    }
    //修改个人信息
    func changeUserinfo() {
        
        if ((UserModel.share().getCurrentUser()?.avatarLarge) != ""){
            iconImage.image = UIImage(named: (UserModel.share().getCurrentUser()?.avatarLarge) ?? "")
            iconImage.image = UIImage(named: "default-head")
        }
        else{
            iconImage.image = UIImage(named: "default-head")
        }
        
        if ((UserModel.share().getCurrentUser()?.screenName) != "") {
            nameLabel.text = UserModel.share().getCurrentUser()?.screenName
            nameLabel.sizeToFit()
        }
        else{
            nameLabel.text = "---"
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //登录成功
    func updateUI()  {
//        
//        if ((UserModel.share().getCurrentUser()?.avatarLarge) != "" && (UserModel.share().getCurrentUser()?.avatarLarge) == "default-head"){
//            iconImage.image = UIImage(named: (UserModel.share().getCurrentUser()?.avatarLarge) ?? "")
//            iconImage.image = UIImage(named: "default-head")
//        }
//        else{
//            iconImage.image = UIImage(named: "default-head")
//        }
//        
//        if ((UserModel.share().getCurrentUser()?.screenName) != "") {
//            nameLabel.text = UserModel.share().getCurrentUser()?.screenName
//            nameLabel.sizeToFit()
//        }
//        else{
//            nameLabel.text = UserModel.share().currentUser?.phone
//        }
        
        loginSuccessIs(bool: true)
        memberImageView.isHidden = UserModel.share().getCurrentUser()?.type == 0
        //用户余额数据请求
        UserModel.share().currentUser?.addObserver(self, forKeyPath: AppConst.KVOKey.balance.rawValue, options: .new, context: nil)
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in

            if let object = result as? Dictionary<String,Any> {
                if let  money =  object["balance"] as? Double {
                self?.setBalanceText(balance: money)
                } else {
                    self?.nameLabel.text =  "0.00"
                }
            }
//            //个人信息数据请求
//            AppAPIHelper.user().getUserinfo(complete: { [weak self](result) -> ()? in
//                if let modes: [UserInfo] = result as? [UserInfo]{
//                    let model = modes.first
//                    UserModel.updateUser(info: { (result) -> ()? in
//                        if model!.avatarLarge != nil {
//                            UserModel.share().getCurrentUser()?.avatarLarge = model!.avatarLarge
//                        }
//                        UserModel.share().getCurrentUser()?.screenName = model!.screenName
//                        UserModel.share().getCurrentUser()?.phone = model!.phone
//                        return nil
//                    })
//                }
//                return nil
//                }, error: self?.errorBlockFunc())
            return nil
            }, error: errorBlockFunc())
        
        
        
    }
    
    func quitEnterClick() {
        loginSuccessIs(bool: false)
        iconImage.image = UIImage(named: "default-head.png")
    }
    
    //MARK: -- 判断是否登录成功
    func loginSuccessIs(bool:Bool){
        nameLabel.isHidden = bool ? false : true
        yuanLabel.isHidden = bool ? false : true
//        concealLabel.isHidden = bool ? true : false
        loginBtn.isHidden = bool ? true : false
        register.isHidden = bool ? true : false
        pushBtn.isHidden = bool ? false : true
        myPropertyBtn.isHidden = bool ? false : true
        propertyNumber.isHidden = bool ? false : true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 {
            
            return 10
        }
        return 0
    }
    //登录按钮
    @IBAction func logout(_ sender: Any) {
        AppDataHelper.instance().clearUserInfo()
        sideMenuController?.toggle()
    }
    @IBAction func enterDidClick(_ sender: Any) {
        
        if checkLogin() {
            
        }
        
    }
    //注册按钮
    @IBAction func registerDidClick(_ sender: Any) {
        
        let homeStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        let nav: UINavigationController = homeStoryboard.instantiateInitialViewController() as! UINavigationController
        let controller = homeStoryboard.instantiateViewController(withIdentifier: RegisterVC.className())
        controller.title = "注册"
        nav.pushViewController(controller, animated: true)
        present(nav, animated: true, completion: nil)
        
    }
    //我的资产
    @IBAction func myPropertyDidClick(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyWealtVC), object: nil, userInfo: nil)
//        sideMenuController?.toggle()
    }
    //个人中心
    @IBAction func myMessageDidClick(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyMessage), object: nil, userInfo: nil)
//        sideMenuController?.toggle()
    }
    //我的积分
    @IBAction func myIntegral(_ sender: Any) {
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jumpNotifyDict[indexPath.section]!), object: nil, userInfo: nil)
        sideMenuController?.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    deinit {
        UserModel.share().currentUser?.removeObserver(self, forKeyPath: "balance")
        NotificationCenter.default.removeObserver(self)
    }
    
}
