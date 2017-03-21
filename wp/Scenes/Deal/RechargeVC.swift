//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
class RechargeVC: BaseTableViewController ,WXApiDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate , UITextFieldDelegate{
    
    var selectType =  Int()
     var rangePoint:NSRange!
     var isFirst = true
    //选择支付方式 0银联 1 微信
    var rid = Int64()
    @IBOutlet weak var arrow: UIImageView!                     // 箭头
    @IBOutlet weak var userIdText: UITextField!                //用户账户
    var  responseData = NSMutableData()                        //返回的数据
    @IBOutlet weak var moneyText: UITextField!                 //余额
    @IBOutlet weak var bankCount: UITextField!                 //银行卡号
    @IBOutlet weak var rechargeMoneyTF: UITextField!           //充值金额
    @IBOutlet weak var rechargeTypeLabel: UILabel!             //充值方式*
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!    //自定义cell
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!     //自定义cell
    @IBOutlet weak var bankTableView: RechargeVcTableView!    //银行卡view
    @IBOutlet weak var submited: UIButton!    //提交按钮
    var selectRow : Bool!                                     // 来用来判断刷新几个区
    
    
    
    //MARK: - 界面销毁删除监听
    deinit {
        ShareModel.share().shareData.removeValue(forKey: "rid")
        ShareModel.share().removeObserver(self, forKeyPath: "userMoney")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AppConst.UnionPay.UnionErrorCode), object: nil)
    }
    //MARK: - UI
    override func viewDidLoad() {
        super.viewDidLoad()
        selectRow = false
        title = "充值"
        selectType = 1
        initData()
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()

    }
    func initUI(){
        selectType = 1
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("充值记录", for:  UIControlState.normal)
        btn.addTarget(self, action: #selector(rechargeList), for: UIControlEvents.touchUpInside)
        //        self.bankCount.text = "0" + " " + "张"
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        NotificationCenter.default.addObserver(self, selector: #selector(paysuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorCode(_:)), name: NSNotification.Name(rawValue: AppConst.UnionPay.UnionErrorCode), object: nil)
        self.userIdText.text = UserModel.share().currentUser?.phone ?? ""
        self.userIdText.isUserInteractionEnabled = false
        submited.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        submited.layer.cornerRadius = 5
        submited.clipsToBounds = true
        ShareModel.share().addObserver(self, forKeyPath: "userMoney", options: .new, context: nil)
        moneyText.dk_textColorPicker = DKColorTable.shared().picker(withKey: "auxiliary")
        rechargeMoneyTF.delegate = self
//        rechargeMoneyTF.addTarget(self, action: #selector(TextFieldchange(_:)), for: UIControlEvents.valueChanged)
    }
    //MARK: - DATA
    func initData() {
        didRequest()
        
    }
   
//    }
    //MARK: - 进入充值列表
    func rechargeList(){
        self.performSegue(withIdentifier: "PushTolist", sender: nil)
    }
  
    //MARK: - 进入绑定银行卡
    @IBAction func addBank(_ sender: Any) {
        self.performSegue(withIdentifier: "addBankCard", sender: nil)
    }
    //MARK: - 提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        //kURL_TN_Normal
        if selectType == 0 {
            if checkTextFieldEmpty([self.rechargeMoneyTF]) {
                
                SVProgressHUD.show(withStatus: "加载中")
                var money : String
                if ((self.rechargeMoneyTF.text?.range(of: ".")) != nil) {
                    money = self.rechargeMoneyTF.text!
                }else{
                    money = "\(self.rechargeMoneyTF.text!)" + ".00001"
                }
                AppAPIHelper.user().unionpay(title: "余额充值", price: Double.init(money)!, complete: { (result) -> ()? in
                    
                    SVProgressHUD.dismiss()
                    if let object = result {
                        //ShareModel.share().shareData["rid"] =  object["rid"] as! String!
                        self.rid = object["rid"] as! Int64
                        UPPaymentControl.default().startPay(object["tn"]  as! String!, fromScheme: "com.newxfin.goods", mode: "00", viewController: self)
                    }
                    return nil
                }, error: errorBlockFunc())
                
            }
        }else{
            if checkTextFieldEmpty([self.rechargeMoneyTF]) {
                
                let account : Double = Double.init(self.rechargeMoneyTF.text!)!
                if account <= 0 {
                     return
                }
                var money : String
                SVProgressHUD.show(withStatus: "加载中")
                if ((self.rechargeMoneyTF.text?.range(of: ".")) != nil) {
                    money = self.rechargeMoneyTF.text!
                }else{
                    money = "\(self.rechargeMoneyTF.text!)" + ".00001"
                }
                AppAPIHelper.user().weixinpay(title: "余额充值", price: Double.init(money)! , complete: { (result) -> ()? in
                    SVProgressHUD.dismiss()
                    if let object = result {
                        let request : PayReq = PayReq()
                        let str : String = object["timestamp"] as! String!
                        ShareModel.share().shareData["rid"] =  object["rid"] as! String!
                        request.timeStamp = UInt32(str)!
                        request.sign = object["sign"] as! String!
                        request.package = object["package"] as! String!
                        request.nonceStr = object["noncestr"] as! String!
                        request.partnerId = object["partnerid"] as! String!
                        request.prepayId = object["prepayid"] as! String!
                        WXApi.send(request)
                    }
                    return nil
                }, error: errorBlockFunc())
            }
        }
    }

    //MARK: - 监听银联返回结果
    func errorCode(_ notice: NSNotification){
        
        if let errorCode: String = notice.object as? String{
            
            if errorCode == "cancel" {
                SVProgressHUD.showError(withStatus: "支付失败")
            }
            else if errorCode == "success"{
                
                SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
                    _ = self.navigationController?.popViewController(animated: true)
                })
                //                AppAPIHelper.user().unionpayResult(rid: self.rid, payResult: 1, complete: { (result) -> ()? in
                //                    SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
                //                        self.navigationController?.popViewController(animated: true)
                //                        })
                //                    if let object = result{
                //                        let  returnCode : Int = object["returnCode"] as! Int
                //                        if returnCode == 0{//                                self.navigationController?.popViewController(animated: true)
                //                            })
                //                        }else{
                //                            SVProgressHUD.showError(withStatus: "支付失败")
                //                        }
                //                    }
                //                    return nil
                //                }, error: errorBlockFunc())
            }
        }
    }
    //MARK: -监听微信支付返回结果
    func paysuccess(_ notice: NSNotification) {
        if let errorCode: Int = notice.object as? Int{
            //            var code = Int()
            if errorCode == 0 {
                return
                
            }
            else if errorCode == -4{
                SVProgressHUD.showError(withStatus: "支付失败")
                return
            }
            else   if errorCode == -2{
                SVProgressHUD.showError(withStatus: "用户中途取消")
                return
            }
        }

        
    }
    //MARK: -获取银行卡数量的请求
    override func didRequest() {
        //用来判断请求
        if UserModel.share().getCurrentUser() != nil{
            let str : String =  String.init(format:  "%.2f", (UserModel.share().getCurrentUser()?.balance)!)
            let int : Double = Double(str)!
            let format = NumberFormatter()
            format.numberStyle = .currency
            let account : String =   format.string(from: NSNumber(value: int))!
            self.moneyText.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "￥").last?.components(separatedBy: "$").last)! + "元"
//            self.moneyText.placeholder = "最多可提现" + "\(int)" + "元"
        }
         //请求金额
        AppAPIHelper.user().accinfo(complete: {[weak self] (result) -> ()? in
            if let resultDic = result as? [String: AnyObject] {
                if let money = resultDic["balance"] as? Double{
                    
                    UserModel.updateUser(info: { (result) -> ()? in
                        UserModel.share().getCurrentUser()?.balance = Double(money)
                        return nil
                    })
                    let format = NumberFormatter()
                    format.numberStyle = .currency
                    let account : String =   format.string(from: NSNumber(value: money))!
                    self?.moneyText.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "￥").last?.components(separatedBy: "$").last)! + "元"
                }
            }
            return nil
            }, error: errorBlockFunc())
      
    }
    // MARK: - 属性的变化 后台返回余额变化进入充值列表
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "userMoney" {
              let  account = String.init(format: "%.2f", ShareModel.share().userMoney)
              self.moneyText.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "￥").last?.components(separatedBy: "$").last)! + "元"
              SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 2, completion: {
                self.performSegue(withIdentifier: "PushTolist", sender: nil)
            })
            
        }
    }
    
    //MARK: - tableView dataSource
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0 {
            return 2
        }
        if section==1 {
            return 3
        }
        if selectRow == true  {
            return 1
        }else{
            return 0
        }
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        if(indexPath.section==1){
////            if indexPath.row == 2 {
////                let  cell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 2, section: 1) as IndexPath)!
////                cell.accessoryType =  .checkmark
////                selectType = 1
////                let  uncell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 3, section: 1) as IndexPath)!
////                uncell.accessoryType =  .none
////            }
////            if indexPath.row == 3 {
////                selectType = 0
////                let  cell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 3 , section: 1) as IndexPath)!
////                cell.accessoryType =  .checkmark
////                let  uncell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 2, section: 1) as IndexPath)!
////                uncell.accessoryType =  .none
////            }
////        }
//    }
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
    
   
    

    
}
