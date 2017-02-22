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
class RechargeVC: BaseTableViewController ,WXApiDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate{
    
    
    
    var selectType =  Int()                                    //选择支付方式 0银联 1 微信
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: --UI
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    deinit {
        ShareModel.share().shareData.removeValue(forKey: "rid")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AppConst.UnionPay.UnionErrorCode), object: nil)
    }
    func initUI(){
        
        selectType = 0
        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*0.5))
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("充值记录", for:  UIControlState.normal)
        btn.addTarget(self, action: #selector(rechargeList), for: UIControlEvents.touchUpInside)
//        if  let str : String = NSString(format: "%.2f" , (UserModel.getCurrentUser()?.balance)!) as String {
//           self.moneyText.text  = "\(str)" + "元"
//        }
     
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        NotificationCenter.default.addObserver(self, selector: #selector(paysuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorCode(_:)), name: NSNotification.Name(rawValue: AppConst.UnionPay.UnionErrorCode), object: nil)
        self.userIdText.text = UserModel.share().getCurrentUser()?.phone
        self.userIdText.isUserInteractionEnabled = false
        //        self.userIdText.text  =
        //        self.bankTableView.addObserver(self, forKeyPath: "dataArry", options: .new, context: nil)
        submited.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        submited.layer.cornerRadius = 5
        submited.clipsToBounds = true
        
        moneyText.dk_textColorPicker = DKColorTable.shared().picker(withKey: "auxiliary")
        
    }
    //MARK: 属性的变化
    //    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //
    //        if keyPath == "dataArry" {
    //
    //            if let  base = change? [NSKeyValueChangeKey.newKey] as? [BankListModel] {
    //
    //                let Count : Int = base.count as Int
    //                let str : String = String(Count)
    //                bankCount.text = "\(str)" + " " + "张"
    //
    //            }
    //        }
    //    }
    //MARK:-进入充值吗列表页面
    func rechargeList(){
        self.performSegue(withIdentifier: "PushTolist", sender: nil)
    }
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        selectRow = false
        title = "充值"
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        didRequest()
    }
    //MARK: -进入绑定银行卡
    @IBAction func addBank(_ sender: Any) {
        self.performSegue(withIdentifier: "addBankCard", sender: nil)
    }
    //MARK: -提交
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
                AppAPIHelper.user().unionpay(title: "微盘-余额充值", price: Double.init(money)!, complete: { (result) -> ()? in
                 
                      SVProgressHUD.dismiss()
                    if let object = result {
                       
//                        ShareModel.share().shareData["rid"] =  object["rid"] as! String!
                        self.rid = object["rid"] as! Int64
                        UPPaymentControl.default().startPay(object["tn"]  as! String!, fromScheme: "UPPayDemo", mode: "01", viewController: self)
                    }
                    return nil
                }, error: errorBlockFunc())
                //                let urlRequest : NSURLRequest = NSURLRequest.init(url:   NSURL.init(string: "http://101.231.204.84:8091/sim/getacptn") as! URL)
                //                let urlConn : NSURLConnection = NSURLConnection.init(request: urlRequest as URLRequest, delegate: self)!
                //                urlConn.start()
            }
        }else{
            if checkTextFieldEmpty([self.rechargeMoneyTF]) {
                var money : String
                if ((self.rechargeMoneyTF.text?.range(of: ".")) != nil) {
                    money = self.rechargeMoneyTF.text!
                    
                    
                }else{
                    
                    money = "\(self.rechargeMoneyTF.text!)" + ".00001"
                }
                AppAPIHelper.user().weixinpay(title: "余额充值", price: Double.init(money)! , complete: { (result) -> ()? in
                    if let object = result {
                        let request : PayReq = PayReq()
                        let  str : String  = object["timestamp"] as! String!
                        ShareModel.share().shareData["rid"] =  object["rid"] as! String!
                        request.timeStamp = UInt32(str)!
                        request.sign = object["sign"] as! String!
                        request.package = object["package"] as! String!
                        request.nonceStr = object["noncestr"] as! String!
                        request.partnerId = object["partnerid"] as! String!
                        request.sign = object["sign"] as! String!
                        request.prepayId = object["prepayid"] as! String!
                        WXApi.send(request)
                    }
                    return nil
                }, error: errorBlockFunc())
            }
        }
    }
    //MARK: -tableView dataSource
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section==0 {
            return 2
        }
        if section==1 {
            return 5
        }
        if selectRow == true  {
            return 1
        }else{
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section==1){
            if indexPath.row == 3 {
                let  cell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 3, section: 1) as IndexPath)!
                cell.accessoryType =  .checkmark
                selectType = 0
                let  uncell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 4, section: 1) as IndexPath)!
                uncell.accessoryType =  .none
            }
            if indexPath.row == 4 {
                selectType = 1
                let  cell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 4 , section: 1) as IndexPath)!
                cell.accessoryType =  .checkmark
                let  uncell : UITableViewCell = tableView.cellForRow(at: NSIndexPath.init(row: 3, section: 1) as IndexPath)!
                uncell.accessoryType =  .none
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    //MARK: -银联支付sdk调用
    //    func connection(_ connection: NSURLConnection, didReceive response: URLResponse){
    //
    //        let rsp : HTTPURLResponse = response as! HTTPURLResponse
    //        let code : NSInteger = rsp.statusCode
    //        if code != 200{
    //        }
    //        else
    //        {
    //            responseData = NSMutableData()
    //        }
    //    }
    //    func connection(_ connection: NSURLConnection, didReceive data: Data){
    //
    //        responseData.append(data)
    //    }
    //    func connectionDidFinishLoading(_ connection: NSURLConnection){
    //
    //        let tn : String = NSMutableString.init(data: responseData as Data, encoding: 4)! as String
    //        if  tn.length()>0  {
    //            UPPaymentControl.default().startPay(tn as String!, fromScheme: "UPPayDemo", mode: "01", viewController: self)
    //        }
    //    }
    //MARK: 监听返回结果
    func errorCode(_ notice: NSNotification){
        
        if let errorCode: String = notice.object as? String{
            
            if errorCode == "cancel" {
                SVProgressHUD.showError(withStatus: "支付失败")
            }
            else if errorCode == "success"{

                SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
                    self.navigationController?.popViewController(animated: true)
                    })
//                AppAPIHelper.user().unionpayResult(rid: self.rid, payResult: 1, complete: { (result) -> ()? in
//                    SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
//                        self.navigationController?.popViewController(animated: true)
//                        })
//                    if let object = result{
//                        let  returnCode : Int = object["returnCode"] as! Int
//                        if returnCode == 0{
//                            SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
//                                self.navigationController?.popViewController(animated: true)
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
    //MARK: 监听返回结果
    func paysuccess(_ notice: NSNotification) {
        
        
        if let errorCode: Int = notice.object as? Int{
            var code = Int()
            if errorCode == 0 {
            code = 1
            }else{
                code = 2
            }
            AppAPIHelper.user().rechargeResults(rid: Int64( ShareModel.share().shareData["rid"]!)!, payResult: code, complete: { (result) -> ()? in
                if let object = result{
                    if let  returnCode : Int = object["returnCode"] as? Int{
                        if returnCode == 1{
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }else{
                            SVProgressHUD.showError(withStatus: "支付失败")
                        }
                    }else if let  returnCode : Int = object["error"] as? Int{
                        SVProgressHUD.showError(withStatus: "支付失败")
                        
                    }
                   
                }
                return nil
            }, error: errorBlockFunc())
        }
        //        if let errorCode: Int = notice.object as? Int{
        //            if errorCode == -4{
        //
        //                return
        //            }
        //            if errorCode == -2{
        //
        //                SVProgressHUD.showError(withStatus: "用户中途取消")
        //                return
        //            }
        //            if errorCode == 0{
        //                SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1
        //                    , completion: {
        //
        //                })
        //                return
        //            }
        //
        //        }
        
    }
    //MARK: -获取银行卡数量的请求
    override func didRequest() {
                AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
                    if let object = result {
                        let Model : BankModel = object as! BankModel
                        let Count : Int = (Model.cardlist?.count)!
                        let str : String = String(Count)
                        self?.bankCount.text = "\(str)" + " " + "张"
                    }else {
                    }
                    
                    return nil
                    }, error: errorBlockFunc())
    }
    
}
