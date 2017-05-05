//
//  EasyRechargeVC.swift
//  wp
//
//  Created by mu on 2017/4/21.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
import SVProgressHUD

class EasyRechargeVC: BaseTableViewController, UITextFieldDelegate {
    //UI属性
    @IBOutlet weak var uidText: UITextField!
    @IBOutlet weak var balanceText: UITextField!
    @IBOutlet weak var countText: UITextField!
    @IBOutlet weak var submitText: UIButton!
    @IBOutlet weak var rechargeTypeText: UITextField!
    
    //变量属性
    var haveRecharge = false
    enum EasyPayType: String {
        case none = ""
        case alipay = "ALIPAY_QRCODE_PAY"
        case wechat = "WECHAT_QRCODE_PAY"
        case H5 = "H5_ONLINE_BANK_PAY"
    }
    var rechargeType: EasyPayType = .none
    
    //lifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if haveRecharge{
            showRechargeResultAlter()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideTabBarWithAnimationDuration()
        initUserInfo()
    }
   
    //userInfo
    func initUserInfo() {
        uidText.text = UserModel.share().currentUser?.phone
        balanceText.text = "\(UserModel.share().balance)元"
        submitText.layer.cornerRadius = 5
        submitText.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        let closeKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(tableCloseKeyboard))
        tableView.addGestureRecognizer(closeKeyboard)
    }
    func tableCloseKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func rechargeBtnTapped(_ sender: UIButton) {
        
        if rechargeType == .none{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请选择支付方式", ForDuration: AppConst.progressDuration, completion: nil)
            return
        }
        
        if checkTextFieldEmpty([countText]){
            
            if Double(countText.text!)! < 100{
                SVProgressHUD.showErrorMessage(ErrorMessage: "最低充值金额为100", ForDuration: AppConst.progressDuration, completion: nil)
                return
            }
            
            SVProgressHUD.showProgressMessage(ProgressMessage: "正在提交订单...")
            let param = RechargeParam()
            param.payType = rechargeType.rawValue
            param.amount = Double(countText.text!)!
            AppAPIHelper.user().easypayRecharge(param: param, complete: { [weak self](result) -> ()? in
                SVProgressHUD.dismiss()
                if let model = result as? RechargeResultModel{
                    self?.haveRecharge = true
                    sender.isEnabled = true
                    self?.openURL(urlStr: model.paymentInfo)
                }
                return nil
                }, error: errorBlockFunc())
        }else{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入充值金额", ForDuration: AppConst.progressDuration, completion: nil)
        }
    }
    
    func openURL(urlStr: String) {
//        let webController = WPWebViewController()
//        webController.title = "充值"
//        _ = navigationController?.pushViewController(webController, animated: true)
//        let baseUrl = URL.init(string: urlStr)
//        webController.webView.loadRequest(URLRequest.init(url: baseUrl!))
//      
        UserModel.share().qrcodeStr = urlStr
        let platform = rechargeType == .alipay ? "支付宝":"微信"
        UserModel.share().qrcodeTitle  = "长按二维码保存到相册,然后打开\(platform)进行充值"
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: QRCodeVC.className())
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showRechargeResultAlter() {
        SVProgressHUD.dismiss()
        let alter = UIAlertView.init(title: "充值结果", message: "是否完成了充值？", delegate: self, cancelButtonTitle: "遇到问题", otherButtonTitles: "完成")
        alter.show()
    }
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        haveRecharge = false
        if buttonIndex == 1 {
            performSegue(withIdentifier: RechargeListVC.className(), sender: nil)
            return
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK: - textField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == rechargeTypeText {
            return false
        }
        let resultStr = textField.text?.replacingCharacters(in: (textField.text?.range(from: range))!, with: string)
        return resultStr!.isMoneyString()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == rechargeTypeText {
            let actionController = UIAlertController.init(title: "充值", message: "请选择支付方式", preferredStyle: .actionSheet)
            let alipyAction = UIAlertAction.init(title: "支付宝支付", style: .default, handler: { [weak self](result) in
                self?.rechargeType = .alipay
                self?.rechargeTypeText.text = "支付宝支付"
            })
            actionController.addAction(alipyAction)
            let wechatAction = UIAlertAction.init(title: "微信支付", style: .default, handler: { [weak self](result) in
                self?.rechargeType = .wechat
                self?.rechargeTypeText.text = "微信支付"
            })
            actionController.addAction(wechatAction)
            present(actionController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
   
}
