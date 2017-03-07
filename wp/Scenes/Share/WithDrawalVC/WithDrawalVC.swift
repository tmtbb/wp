//
//  WithDrawalVC.swift
//  wp
//
//  Created by sum on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
class WithDrawalVC: BaseTableViewController {
    //提现提交按钮
    @IBOutlet weak var submited: UIButton!
    var bankId : Int64 = 0
    // 发送验证码
    @IBOutlet weak var voiceCodeBtn: UIButton!
    // 定时器
    private var timer: Timer?
    // 时间
    private var codeTime = 60
    // 银行名
    @IBOutlet weak var bankTd: UITextField!
    // 支行名称
    @IBOutlet weak var branceTd: UITextField!
    //  姓名
    @IBOutlet weak var nameTd: UITextField!
    //  银行卡号
    @IBOutlet weak var bankNumberLb: UITextField!
    //  全部提现
    @IBOutlet weak var withDrawAll: UIButton!
    @IBOutlet weak var codeTd: UITextField!
    // 金额
    @IBOutlet weak var money: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "提现"
        
        // 设置 提现记录按钮
        initUI()
        
        ShareModel.share().addObserver(self, forKeyPath: "selectBank", options: .new, context: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        hideTabBarWithAnimationDuration()
        
    }
    //MARK:  界面销毁删除监听
    deinit {
        ShareModel.share().removeObserver(self, forKeyPath: "selectBank", context: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    // MARK - 导航栏右侧
    func initUI(){
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        btn.setTitle("提现记录", for:  UIControlState.normal)
        
        btn.addTarget(self, action: #selector(withDrawList), for: UIControlEvents.touchUpInside)
        
        let str : String =  String.init(format:  "%.2f", (UserModel.share().getCurrentUser()?.balance)!)
        let int : Double = Double(str)!
        self.money.placeholder = "最多可提现" + "\(int)" + "元"
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        
        submited.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        submited.layer.cornerRadius = 5
        submited.clipsToBounds = true
        withDrawAll.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: "auxiliary"), for: .normal)
        
        
    }
    //MARK: --属性的变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "selectBank" {
            
            if let base = change? [NSKeyValueChangeKey.newKey] as? BankListModel {
                
                
                bankId =  Int64(base.bid)
                self.bankTd.text! = base.bank
                self.branceTd.text! = base.branchBank
                self.bankNumberLb.text! = base.cardNo
                self.nameTd.text!=base.name
            }
        }
    }
    
    // MARK: -进入提现列表
    func withDrawList(){
        
        self.performSegue(withIdentifier: "PushTolist", sender: nil)
        
    }
    //MARK: -提现
    @IBAction func withDraw(_ sender: Any) {
        
        // 校验 是否选择银行卡和提现最多金额
        let str : String = NSString(format: "%.2f" , (UserModel.share().getCurrentUser()?.balance)!) as String
        let account  :  Double = Double(str)!
        
        if self.money.text?.length()==0{
            SVProgressHUD.showError(withStatus: "请输入提现金额")
            return
        }
    
        let input : Double = Double(self.money.text!)!
        if  bankId == 0{
            SVProgressHUD.showError(withStatus: "请选择银行卡")
            return
        }
        if account < input{
            
            SVProgressHUD.showError(withStatus: "最多提现" + "\(account)" + "元")
            return
        }
        let alertView = UIAlertView.init()
        alertView.alertViewStyle = UIAlertViewStyle.secureTextInput // 密文
        alertView.title = "请输入交易密码"
        alertView.addButton(withTitle: "确定")
        alertView.addButton(withTitle: "取消")
        alertView.delegate = self
        alertView.show()
    }
    
    //输入密码 的代理方法
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex==0{
            
            if buttonIndex==0{
                var money : String
                if ((self.money.text?.range(of: ".")) != nil) {
                    //来判断是否包含小数点
                    if ((self.money.text?.range(of: ".00")) != nil) {
                      let arr : Array = (self.money.text?.components(separatedBy: "."))!
                        money = arr[0] + ".000001"
                    }
                    else  if ((self.money.text?.range(of: ".0")) != nil) {
                        let arr : Array = (self.money.text?.components(separatedBy: "."))!
                        let number : String = arr[1] as String
                        if number.length()>1 {
                            print("123")
                            money = self.money.text!
                        }else{
                         money = arr[0] + ".000001"
                        }
                    } else  if ((self.money.text?.range(of: ".")) != nil){
                        let arr : Array = (self.money.text?.components(separatedBy: "."))!
        
                        if arr.count > 1{
                            if arr[1] != ""{
                                if arr[0] != "" {
                                    money = "0" + self.money.text!
                                }else{
                                    money = self.money.text!
                                }
                            }else{
                             money = arr[0] + ".000001"
                            }
                        }else {
                            money = arr[0] + ".000001"
                        }
                    }
                    else{
                        money = self.money.text!
                    }
                }else{
                    money = "\(self.money.text!)" + ".000001"
                }
                
                
              let password = (((alertView.textField(at: 0)?.text)! + AppConst.sha256Key).sha256()+(UserModel.share().getCurrentUser()?.phone!)!).sha256()
//                let passWord : String = (((alertView.textField(at: 0)?.text)! + AppConst.sha256Key).sha256()+(alertView.textField(at: 0)?.text)!).sha256()
                AppAPIHelper.user().withdrawcash(money: Double.init(money)!, bld: bankId, password: password, complete: { [weak self](result) -> ()? in
                    
                    if let object = result{
                        let Model : WithdrawModel = object as! WithdrawModel
                        ShareModel.share().detailModel = Model
                        if( ShareModel.share().detailModel.status == -3){
                            SVProgressHUD.showError(withStatus: "提现密码错误")
                            return nil
                        }
                        self?.performSegue(withIdentifier: "SuccessWithdrawVC", sender: nil)
                    }
                    return nil
                    }, error: errorBlockFunc())
            }
        }
    }
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        
        AppAPIHelper.commen().verifycode(verifyType: Int64(1), phone: (UserModel.share().getCurrentUser()?.phone)!, complete: { [weak self](result) -> ()? in
            if let strongSelf = self{
                if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
                    if let token = resultDic[SocketConst.Key.vToken]{
                        UserModel.share().codeToken = token as! String
                    }
                    if let timestamp = resultDic[SocketConst.Key.timestamp]{
                        UserModel.share().timestamp = timestamp as! Int
                    }
                }
                strongSelf.voiceCodeBtn.isEnabled = false
                strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.updateBtnTitle), userInfo: nil, repeats: true)
            }
            return nil
            }, error: errorBlockFunc())

//        self.voiceCodeBtn.isEnabled = false
//        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateBtnTitle), userInfo: nil, repeats: true)
    }
    func updateBtnTitle() {
        if codeTime == 0 {
            voiceCodeBtn.isEnabled = true
            voiceCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            return
        }
        voiceCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)S"
        voiceCodeBtn.setTitle(title, for: .normal)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //pushaddBank
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "pushaddBank", sender: nil)
            }
        }
    }
    //MARK: 全部提现导航栏
    @IBAction func withDrawAll(_ sender: Any) {
        //        self.money.text
        let str : String = NSString(format: "%.2f" , (UserModel.share().getCurrentUser()?.balance)!) as String
        self.money.text = str
    }
}




