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
class WithDrawalVC: BaseTableViewController ,UITextFieldDelegate {
  
    @IBOutlet weak var submited: UIButton!        //提现提交按钮
//    var bankId : Int64 = 0
    var bankId : Int64 = 49
    var accountmoney : Double = 0                      // 提现金额
    @IBOutlet weak var voiceCodeBtn: UIButton!         // 发送验证码
    var timer: Timer?                                  // 定时器
    var codeTime = 60                                  // 时间
    @IBOutlet weak var bankTd: UITextField!            // 银行名
    @IBOutlet weak var branceTd: UITextField!          // 支行名称
    @IBOutlet weak var nameTd: UITextField!            //  姓名
    @IBOutlet weak var bankNumberTd: UITextField!      //  银行卡号
    @IBOutlet weak var withDrawAll: UIButton!          //  全部提现
    @IBOutlet weak var codeTd: UITextField!
    @IBOutlet weak var moneyTd: UITextField!              // 金额
    var rangePoint:NSRange!
    var isFirst = true
    //MARK: - initUI()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "提现"
        // 设置 提现记录按钮
        initUI()
        ShareModel.share().addObserver(self, forKeyPath: "selectBank", options: .new, context: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        hideTabBarWithAnimationDuration()
        
        self.moneyTd.delegate = self
        
    }
    func initUI(){
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("提现记录", for:  UIControlState.normal)
        btn.addTarget(self, action: #selector(withDrawList), for: UIControlEvents.touchUpInside)
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        
        submited.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        submited.layer.cornerRadius = 5
        submited.clipsToBounds = true
        withDrawAll.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: "auxiliary"), for: .normal)
        //
        initData()
        
        
    }
    func initData(){
        if UserModel.share().getCurrentUser() != nil{
            let str : String =  String.init(format:  "%.2f", (UserModel.share().getCurrentUser()?.balance)!)
            let int : Double = Double(str)!
            self.moneyTd.placeholder = "最多可提现" + "\(int)" + "元"
            
            accountmoney = (UserModel.share().getCurrentUser()?.balance)!
        }
        
        AppAPIHelper.user().accinfo(complete: {[weak self] (result) -> ()? in
            if let resultDic = result as? [String: AnyObject] {
                if let moneyTd = resultDic["balance"] as? Double{
                    
                    self?.accountmoney = moneyTd
                    
                    let str : String =  String.init(format:  "%f", moneyTd)
                    self?.moneyTd.placeholder = "最多可提现" + "\(str)" + "元"
                    
                    UserModel.updateUser(info: { (result) -> ()? in
                        UserModel.share().getCurrentUser()?.balance = Double(moneyTd)
                        return nil
                    })
                    
                }
            }
            return nil
            }, error: errorBlockFunc())
    }
    //MARK: - 界面销毁删除监听
    deinit {
        ShareModel.share().removeObserver(self, forKeyPath: "selectBank", context: nil)
    }
    
    //MARK: - 属性的变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "selectBank" {
            
            if let base = change? [NSKeyValueChangeKey.newKey] as? BankListModel {
                bankId =  Int64(base.bid)
                self.bankTd.text! = base.bank
                self.branceTd.text! = base.branchBank
                self.bankNumberTd.text! = base.cardNo
                self.nameTd.text!=base.name
            }
        }
    }
    
    // MARK: - 进入提现列表
    func withDrawList(){
        self.performSegue(withIdentifier: "PushTolist", sender: nil)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    //MARK: - 提现
    @IBAction func withDraw(_ sender: Any) {
        if !checkTextFieldEmpty([bankTd,branceTd,nameTd,bankNumberTd]){
            return
        }
        
        // 校验 是否选择银行卡和提现最多金额
//        let str : String = NSString(format: "%.2f" , (UserModel.share().getCurrentUser()?.balance)!) as String
        let account  = accountmoney
        let input : Double = Double(self.moneyTd.text!)!
        if self.moneyTd.text?.length()==0{
            SVProgressHUD.showError(withStatus: "请输入提现金额")
            return
        }
        if input < 0.01{
            SVProgressHUD.showError(withStatus: "提现金额大于0.01")
            return
        }
        if Double.init(self.moneyTd.text!) == 0{
            SVProgressHUD.showError(withStatus: "提现金额大于0")
            return
        }
       
        if  bankId == 0{
            SVProgressHUD.showError(withStatus: "请选择银行卡")
            return
        }
        let str : String = NSString(format: "%f" , self.accountmoney) as String
        let count : Double = Double.init(str)!
        if count < input{
            SVProgressHUD.showError(withStatus: "最多提现" + "\(account)" + "元")
            return
        }
//        let alertView = UIAlertView.init()
//        alertView.alertViewStyle = UIAlertViewStyle.secureTextInput // 密文
//        alertView.title = "请输入交易密码"
//        alertView.addButton(withTitle: "确定")
//        alertView.addButton(withTitle: "取消")
//        alertView.delegate = self
//        alertView.show()
          var moneyTd : String
        if ((self.moneyTd.text?.range(of: ".")) != nil) {
            //来判断是否包含小数点
            if ((self.moneyTd.text?.range(of: ".00")) != nil) {
                let arr : Array = (self.moneyTd.text?.components(separatedBy: "."))!
                moneyTd = arr[0] + ".000001"
            }
            else  if ((self.moneyTd.text?.range(of: ".0")) != nil) {
                let arr : Array = (self.moneyTd.text?.components(separatedBy: "."))!
                let number : String = arr[1] as String
                if number.length()>1 {
                    moneyTd = self.moneyTd.text!
                }else{
                    moneyTd = arr[0] + ".000001"
                }
            } else  if ((self.moneyTd.text?.range(of: ".")) != nil){
                let arr : Array = (self.moneyTd.text?.components(separatedBy: "."))!
                
                if arr.count > 1{
                    if arr[1] != ""{
                        if arr[0] != "" {
                            moneyTd = "0" + self.moneyTd.text!
                        }else{
                            moneyTd = self.moneyTd.text!
                        }
                    }else{
                        moneyTd = arr[0] + ".000001"
                    }
                }else {
                    moneyTd = arr[0] + ".000001"
                }
            }
            else{
                moneyTd = self.moneyTd.text!
            }
        }else{
            moneyTd = "\(self.moneyTd.text!)" + ".000001"
        }
        
        AppAPIHelper.user().withdrawcash(money: Double.init(moneyTd)!, bld: bankId, password: "123213213", complete: { [weak self](result) -> ()? in
            
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
    
    //输入密码 的代理方法
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex==0{
            
            if buttonIndex==0{
                
                
              _ = (((alertView.textField(at: 0)?.text)! + AppConst.sha256Key).sha256()+(UserModel.share().getCurrentUser()?.phone!)!).sha256()
//                let passWord : String = (((alertView.textField(at: 0)?.text)! + AppConst.sha256Key).sha256()+(alertView.textField(at: 0)?.text)!).sha256()

            }
        }
    }
//    @IBAction func requestVoiceCode(_ sender: UIButton) {
//        
//        AppAPIHelper.commen().verifycode(verifyType: Int64(1), phone: (UserModel.share().getCurrentUser()?.phone)!, complete: { [weak self](result) -> ()? in
//            if let strongSelf = self{
//                if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
//                    if let token = resultDic[SocketConst.Key.vToken]{
//                        UserModel.share().codeToken = token as! String
//                    }
//                    if let timestamp = resultDic[SocketConst.Key.timestamp]{
//                        UserModel.share().timestamp = timestamp as! Int
//                    }
//                }
//                strongSelf.voiceCodeBtn.isEnabled = false
//                strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.updateBtnTitle), userInfo: nil, repeats: true)
//            }
//            return nil
//            }, error: errorBlockFunc())
//
////        self.voiceCodeBtn.isEnabled = false
////        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateBtnTitle), userInfo: nil, repeats: true)
//    }
//    func updateBtnTitle() {
//        if codeTime == 0 {
//            voiceCodeBtn.isEnabled = true
//            voiceCodeBtn.setTitle("重新发送", for: .normal)
//            codeTime = 60
//            timer?.invalidate()
//            return
//        }
//        voiceCodeBtn.isEnabled = false
//        codeTime = codeTime - 1
//        let title: String = "\(codeTime)S"
//        voiceCodeBtn.setTitle(title, for: .normal)
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        return
        //pushaddBank
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                self.performSegue(withIdentifier: "pushaddBank", sender: nil)
//            }
//        }
    }
    //MARK: - 全部提现导航栏
    @IBAction func withDrawAll(_ sender: Any) {
        //        self.moneyTd.text
        let str : String = NSString(format: "%.2f" , self.accountmoney) as String
        self.moneyTd.text = str
    }
     //MARK: - textField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == "" || string == "\n" {
            if rangePoint != nil {
                if range.location == rangePoint.location {
                    isFirst = true
                }
            }
            return true
        }
        let single : unichar =  (string as NSString).character(at: 0)
        if ( single >= 48 && single <= 57 ) || string == "." {
            if isFirst == true {
                if string == "." {
                    isFirst = false
                    rangePoint = range
                    return true
                }
            }else if isFirst == false {
                if string == "." {
                    return false
                }else if range.location - rangePoint.location > 2 {
                    return false
                }
            }
        }else {return false}
        return true
        
    }
    
//    func onlyInputTheNumber(_ string: String) -> Bool {
//        let numString = "[0-9]*"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", numString)
//        let number = predicate.evaluate(with: string)
//        return number
//    }
}




