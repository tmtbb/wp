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
    @IBOutlet weak var voiceCodeBtn: UIButton!         // 发送验证码
    @IBOutlet weak var bankTd: UITextField!            // 银行名
    @IBOutlet weak var branceTd: UITextField!          // 支行名称
    @IBOutlet weak var nameTd: UITextField!            //  姓名
    @IBOutlet weak var bankNumberTd: UITextField!      //  银行卡号
    @IBOutlet weak var withDrawAll: UIButton!          //  全部提现
    @IBOutlet weak var codeTd: UITextField!
    @IBOutlet weak var moneyTd: UITextField!              // 金额
    @IBOutlet weak var feeLabel: UILabel!
   
    var bankId : Int64 = 49
    
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
        initData()
        bankTd.isUserInteractionEnabled = true
        feeLabel.text = "手续费：每单第三方支付平台将收取1元手续费，限额5万元"
        
    }
    func initData(){
        if UserModel.share().getCurrentUser() != nil{
            let str : String = String.init(format: "%.2f", UserModel.share().balance)
            self.moneyTd.placeholder = "最多可提现" + "\(str)" + "元"
        }
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
        let str : String = String.init(format: "%.2f", UserModel.share().balance)
        if UserModel.share().balance < input{
            SVProgressHUD.showError(withStatus: "最多提现" + "\(str)" + "元")
            return
        }
        
        let param = WithDrawalParam()
        param.amount = input
        param.receiverBankName = ShareModel.share().selectBank.bank
        param.receiverBranchBankName = ShareModel.share().selectBank.branchBank
        param.receiverCardNo = ShareModel.share().selectBank.cardNo
        param.receiverAccountName = ShareModel.share().selectBank.name
        param.bid = Int(ShareModel.share().selectBank.bid)
        SVProgressHUD.showProgressMessage(ProgressMessage: "提交提现申请...")
        AppAPIHelper.user().easypayWithDraw(param: param, complete: { [weak self](result) -> ()? in
            SVProgressHUD.dismiss()
            if let model : WithdrawResultModel = result as? WithdrawResultModel{
                ShareModel.share().detailModel.cardNo = ShareModel.share().selectBank.cardNo
                ShareModel.share().detailModel.bank = ShareModel.share().selectBank.bank
                ShareModel.share().withdrawResultModel = model
                if model.errorMsg.length() == 0{
                    self?.performSegue(withIdentifier: SuccessWithdrawVC.className(), sender: nil)
                }else{
                    SVProgressHUD.showWainningMessage(WainningMessage: model.errorMsg, ForDuration: 1, completion: nil)
                }
            }
            return nil
        }, error: errorBlockFunc())
        
    }

    //MARK: - 全部提现导航栏
    @IBAction func withDrawAll(_ sender: Any) {
        //self.moneyTd.text
        self.moneyTd.text = String.init(format: "%.2f", UserModel.share().balance)
    }
     //MARK: - textField delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == bankTd{
            let segue = AppConst.SegueIndentifier.drawCashToBankListSegue.rawValue
            performSegue(withIdentifier: segue, sender: nil)
            return false
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultStr = textField.text?.replacingCharacters(in: (textField.text?.range(from: range))!, with: string)
        return resultStr!.isMoneyString()
    }
}




