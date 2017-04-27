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
    
    //变量属性
    var haveRecharge = false
    
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
        sender.isEnabled = false
        SVProgressHUD.showProgressMessage(ProgressMessage: "正在提交订单...")
        let param = RechargeParam()
        param.amount = Double(countText.text!)!
        AppAPIHelper.user().easypayRecharge(param: param, complete: { [weak self](result) -> ()? in
            if let model = result as? RechargeResultModel{
                self?.haveRecharge = true
                sender.isEnabled = true
                self?.openURL(urlStr: model.paymentInfo)
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    func openURL(urlStr: String) {
        let webController = WPWebViewController()
        webController.title = "充值"
        _ = navigationController?.pushViewController(webController, animated: true)
        let baseUrl = URL.init(string: urlStr)
        webController.webView.loadRequest(URLRequest.init(url: baseUrl!))
//        UIApplication.shared.openURL(URL(string: urlStr)!)
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
        let resultStr = textField.text?.replacingCharacters(in: (textField.text?.range(from: range))!, with: string)
        return resultStr!.isMoneyString()
    }

}
