//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class RechargeVC: BaseTableViewController ,WXApiDelegate{
    @IBOutlet weak var arrow: UIImageView!
    
    //用户账户
    @IBOutlet weak var userIdText: UITextField!
    
    //余额
    @IBOutlet weak var moneyText: UITextField!
    
    //银行卡号
    @IBOutlet weak var bankCount: UITextField!
    
    //充值金额
    @IBOutlet weak var rechargeMoneyTF: UITextField!
    
    //充值方式*
    @IBOutlet weak var rechargeTypeLabel: UILabel!
    
    //自定义cell
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!
    //自定义cell
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!
    
    @IBOutlet weak var bankTableView: RechargeVcTableView!
    // 来用来判断刷新几个区
    var selectRow : Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.bankTableView.didRequest()
        //     hideTabBarWithAnimationDuration()
    }
    
    
    override func didRequest() {
        //        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
        //
        //            if let object = result {
        //
        //                let Model : BankModel = object as! BankModel
        //                let Count : Int = Model.cardlist!.count as Int
        //                                let str : String = String(Count)
        //                self?.bankCount.text = "\(str)" + " " + "张"
        //
        //            }else {
        //
        //            }
        //
        //            return nil
        //            }, error: errorBlockFunc())
        
        
    }
    //MARK: --UI
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        showTabBarWithAnimationDuration()
        
        
        
    }
    deinit {
        
        //        self.bankTableView.removeObserver(self, forKeyPath: "dataArry", context: nil)
        ShareModel.share().shareData.removeAll()
    }
    func initUI(){
        
        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*0.5))
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        btn.setTitle("充值记录", for:  UIControlState.normal)
        
        btn.addTarget(self, action: #selector(rechargeList), for: UIControlEvents.touchUpInside)
        let int : Int = (UserModel.getCurrentUser()?.balance)!
        
        self.moneyText.text  = "\(int)" + "元"
        
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(paysuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatPay.ErrorCode), object: nil)
        
        
        self.userIdText.text = UserModel.getCurrentUser()?.phone
        
        self.userIdText.isUserInteractionEnabled = false
        
        
        //        self.bankTableView.addObserver(self, forKeyPath: "dataArry", options: .new, context: nil)
        
    }
    //MARK: 监听返回结果
    func paysuccess(_ notice: NSNotification) {
        if let errorCode: Int = notice.object as? Int{
            
            AppAPIHelper.user().rechargeResults(rid: Int64( ShareModel.share().shareData["rid"]!)!, payResult: errorCode, complete: { (result) -> ()? in
                
                if let object = result{
                    
                    let  returnCode : Int = object["returnCode"] as! Int
                    if returnCode == 0{
                        
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "支付成功", ForDuration: 1, completion: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    }else{
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
    //    //MARK: 属性的变化
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
    
    //自动识别银行卡
    @IBAction func bankNumBtnTapped(_ sender: UIButton) {
        
    }
    
    //MARK: -进入绑定银行卡
    @IBAction func addBank(_ sender: Any) {
        
        self.performSegue(withIdentifier: "addBankCard", sender: nil)
        
        
        
    }
    //MARK: -提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        
        if checkTextFieldEmpty([self.rechargeMoneyTF]) {
            var money : String
            if ((self.rechargeMoneyTF.text?.range(of: ".")) != nil) {
                money = self.rechargeMoneyTF.text!
            }else{
                
                money = "\(self.rechargeMoneyTF.text!)" + ".00001"
            }
            AppAPIHelper.user().weixinpay(title: "微盘-余额充值", price: Double.init(money)! , complete: { (result) -> ()? in
                
                if let object = result {
                    
                    let request : PayReq = PayReq()
                    ShareModel.share().shareData.removeValue(forKey: "rid")
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
        
        
        
        
        //        let  story  =  UIStoryboard.init(name: "Share", bundle: nil)
        //
        //        let new  = story.instantiateViewController(withIdentifier: "MyWealtVC")
        //
        //        self.navigationController?.pushViewController(new, animated: true)
        
    }
    
    //MARK: -tableView dataSource
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section==0 {
            return 2
        }
        if section==1 {
            return 4
        }
        if selectRow == true  {
            return 1
        }else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section==1){
            if(indexPath.row == 3){
                
                if selectRow == true {
                    arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*0.5))
                }else{
                    arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI*1.5))
                }
                selectRow = !selectRow
                tableView.reloadSections(IndexSet.init(integer: 2), with: UITableViewRowAnimation.fade)
            }
            
        }
        
    }
    
    
}



