//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class BindingBankVCCell: UITableViewCell {
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 银行名称
    @IBOutlet weak var cardNum: UILabel!
    
    
    // 刷新cell
    func update(_ data: Any!) {
        
        let model:BankListModel? = data as? BankListModel
        bankName.text = model!.bank
        cardNum.text = "\((model!.cardNo as NSString).substring(to: 4))" + "  ****   ****   *** " + "\((model!.cardNo as NSString).substring(from: model!.cardNo.length()-3))"
        
    }
}
class BankCardVC: BaseListTableViewController {
    
    var dataArry : [BankListModel] = []
    override func viewDidLoad() {
        
        self.title = "我的银行卡"
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.didRequest()
    }
    override func didRequest() {
        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
            
            if let object = result {
                let Model : BankModel = object as! BankModel
                self?.didRequestComplete(Model.cardlist as AnyObject)
                self?.dataArry = Model.cardlist!
                self?.tableView.reloadData()
            }else {
                self?.didRequestComplete(nil)
            }
            return nil
            }, error: errorBlockFunc())
        
        
    }
    //MARK: 实现银行卡左滑删除的代理
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index  in
            
            self.UnbindCard(number: indexPath.section)
            
            ShareModel.share().shareData["number"] = "\(indexPath.section)"
            
            
        }
        share.backgroundColor = UIColor.red
        
        return [share]
    }
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArry.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 15
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : BindingBankVCCell = tableView.dequeueReusableCell(withIdentifier: "BankCardVCCell") as! BindingBankVCCell
        
        
        let  Model : BankListModel = self.dataArry[indexPath.section]
        
        cell.update(Model.self)
        return cell
        
    }
    //MARK: 解绑逻辑
    func UnbindCard ( number: Int) {
        
        
        
        AppAPIHelper.commen().verifycode(verifyType: Int64(1), phone: (UserModel.getCurrentUser()?.phone)!, complete: {(result) -> ()? in
            
            if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
                if let token = resultDic[SocketConst.Key.vToken]{
                    UserModel.share().codeToken = token as! String
                }
                if let timestamp = resultDic[SocketConst.Key.timestamp]{
                    UserModel.share().timestamp = timestamp as! Int
                }
            }
            return nil
        }, error: errorBlockFunc())
        
        let alertView = UIAlertView.init()
        alertView.alertViewStyle = UIAlertViewStyle.plainTextInput // 密文
          let str : String = NSString(format: "%@" , (UserModel.getCurrentUser()?.phone)!) as String
        alertView.title = "验证码发送到"  + " " + "\(str)"  + " " + "手机上\n" + " " + "请输入验证码"
        alertView.addButton(withTitle: "确定")
        alertView.addButton(withTitle: "取消")
        alertView.delegate = self
        alertView.show()
        
        
        
        
        
    }
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    //输入密码 的代理方法
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        
        if buttonIndex==0{
            
            if buttonIndex==0{
                
                let  model :BankListModel = self.dataArry[Int(ShareModel.share().shareData["number"]!)!] as BankListModel
                
                AppAPIHelper.user().unbindcard(vToken: UserModel.share().codeToken, bid: Int32(model.bid), timestamp:  Int64(UserModel.share().timestamp) , phone: (UserModel.getCurrentUser()?.phone)!, vCode: (alertView.textField(at: 0)?.text)!, complete: { [weak self](result) -> ()? in
                    
                
    //
                    //                                                self?.tableView.reloadData()
                                        if result != nil{
                                            
                                            let dic : NSDictionary = result as! NSDictionary
                                            if (dic.object(forKey: "error") != nil){
                                                let error : Int = dic.object(forKey: "error") as! Int
                                                if error == -113{
                                                
                                                    SVProgressHUD.showError(withStatus: "验证码错误")
                                                     self?.tableView.reloadData()
                                                    return nil
                                                }
                                            }
                                            self?.didRequest()
                                            self?.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
                                            self?.tableView.reloadData()
                                                                }else{
                    
                                                                }
                    
                    return nil
                    }, error: errorBlockFunc())
                //                AppAPIHelper.user().unbindcard(bankId: model.bid, vCode: (alertView.textField(at: 0)?.text)!, complete: { [weak self](result) -> ()? in
                //
                //                    if result != nil{
                //                        self?.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
                //
                //                        self?.tableView.reloadData()
                //                    }else{
                //
                //                    }
                //
                //                    
                //                    //            self?.didRequest()
                //                    
                //                    return nil
                //                    }, error: errorBlockFunc())
            }
        }
        
        
    }
    
}
