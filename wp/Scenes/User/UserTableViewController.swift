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
    //资金
    @IBOutlet weak var propertyNumber: UILabel!
    @IBOutlet weak var yuanLabel: UILabel!
    //积分
    @IBOutlet weak var integralLabel: UILabel!
    @IBOutlet weak var fenLabel: UILabel!
    //未登录时的占位
    @IBOutlet weak var concealLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //       UserModel.share().getCurrentUser()?.balance
        // ShareModel.share().useMoney = Double(money)
        personBackgroud.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        propertyBackgroud.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.lightBlue)
        integralBackground.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.lightBlue)
        loginBtn.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.auxiliary), for: .normal)
        register.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.auxiliary), for: .normal)
        
        
        ShareModel.share().addObserver(self, forKeyPath: "useMoney", options: .new, context: nil)
        registerNotify()
        //更新token
        AppDataHelper.instance().checkTokenLogin()
        if checkLogin() {
            loginSuccessIs(bool: true)
            propertyNumber.text = "\(UserModel.share().getCurrentUser()!.balance)"
            if ((UserModel.share().getCurrentUser()?.avatarLarge) != "" && UserModel.share().getCurrentUser()?.avatarLarge == "default-head"){
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
        else{
            loginSuccessIs(bool: false)
            tableView.isScrollEnabled = false
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "useMoney" {
            if let base = change? [NSKeyValueChangeKey.newKey] as? Double {
                
                let str : String = NSString(format: "%.2f" ,base) as String
                self.propertyNumber.text =  "\(str)"
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
    //登录成功
    func updateUI()  {
        
        if ((UserModel.share().getCurrentUser()?.avatarLarge) != "" && (UserModel.share().getCurrentUser()?.avatarLarge) == "default-head"){
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
            nameLabel.text = "Bug退散"
        }
        
        loginSuccessIs(bool: true)
        //用户余额数据请求
        AppAPIHelper.user().accinfo(complete: {[weak self](result) -> ()? in
            if let object = result {
                let  money : Double =  object["balance"] as! Double
                let str : String = NSString(format: "%.2f" ,money) as String
                self?.propertyNumber.text =  "\(str)"
                UserModel.updateUser(info: { (result)-> ()? in
                    UserModel.share().currentUser?.balance = Double(str as String)!
                })
            }
            //个人信息数据请求
            AppAPIHelper.user().getUserinfo(complete: { [weak self](result) -> ()? in
                if let modes: [UserInfo] = result as? [UserInfo]{
                    let model = modes.first
                    UserModel.updateUser(info: { (result) -> ()? in
                        if model!.avatarLarge != nil {
                            UserModel.share().getCurrentUser()?.avatarLarge = model!.avatarLarge
                        }
                        UserModel.share().getCurrentUser()?.screenName = model!.screenName
                        UserModel.share().getCurrentUser()?.phone = model!.phone
                        return nil
                    })
                }
                return nil
                }, error: self?.errorBlockFunc())
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
        concealLabel.isHidden = bool ? true : false
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
        print("我的注册")
        
    }
    //我的资产
    @IBAction func myPropertyDidClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyWealtVC), object: nil, userInfo: nil)
        print("我的资产")
        sideMenuController?.toggle()
    }
    //个人中心
    @IBAction func myMessageDidClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyMessage), object: nil, userInfo: nil)
        sideMenuController?.toggle()
    }
    //我的积分
    @IBAction func myIntegral(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section =  indexPath.section
        switch section {
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyAttention), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的关注")
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyPush), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的推单")
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyBask), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("我的晒单")
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToDeal), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            
            print("交易明细")
        case 5:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToFeedback), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("意见反馈")
        case 6:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToProductGrade), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("产品评分")
        case 7:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToAttentionUs), object: nil, userInfo: nil)
            sideMenuController?.toggle()
            print("关注我们")
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    deinit {
     
        NotificationCenter.default.removeObserver(self)
     
        ShareModel.share().removeObserver(self, forKeyPath: "useMoney")
        
        
    }
    
}
