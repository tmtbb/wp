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
    
    @IBOutlet weak var banklogo: UIImageView!
    //银行背景
    @IBOutlet weak var bankBg: UIImageView!
    // 刷新cell
    func update(_ data: Any!) {
        
        let model:BankListModel? = data as? BankListModel
        
       bankBg.backgroundColor =    BankLogoColor.share().readfilefromlocal(string: (model?.bank)!)
        banklogo.image = UIImage.init(named: (model?.bank)!)
        bankName.text = model!.bank
        //"\((model!.cardNo as NSString).substring(to: 4))" + "  ****   ****   *** " + "\((model!.cardNo as NSString).substring(from: model!.cardNo.length()-3))"
        
         let index = model!.cardNo.index(model!.cardNo.startIndex,  offsetBy: 4)
         let index1 = model!.cardNo.index(model!.cardNo.startIndex,  offsetBy: model!.cardNo.length()-3)
        
         cardNum.text =  model!.cardNo.substring(to: index) + "  ****   ****   *** " + model!.cardNo.substring(from: index1)
         banklogo.image = BankLogoColor.share().checkLocalBank(string: (model?.bank)!) ? UIImage.init(named: (model?.bank)!) : UIImage.init(named: "unionPay")
        
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
            self.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
            tableView.reloadData()

//            ShareModel.share().shareData["number"] = "\(indexPath.section)"
//            
//             self.UnbindCard(number: indexPath.section)

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
        
        AppAPIHelper.commen().verifycode(verifyType: Int64(1), phone: (UserModel.share().getCurrentUser()?.phone)!, complete: {(result) -> ()? in
        
//        AppAPIHelper.commen().verifycode(verifyType: Int64(1), phone: (UserModel.share().getCurrentUser()?.phone)!, complete: {(result) -> ()? in
//            
//            if let resultDic: [String: AnyObject] = result as? [String : AnyObject]{
//                if let token = resultDic[SocketConst.Key.vToken]{
//                    UserModel.share().codeToken = token as! String
//                }
//                if let timestamp = resultDic[SocketConst.Key.timestamp]{
//                    UserModel.share().timestamp = timestamp as! Int
//                }
//            }
//            return nil
//        }, error: errorBlockFunc())
//        
//        let alertView = UIAlertView.init()
//        alertView.alertViewStyle = UIAlertViewStyle.plainTextInput // 密文
//          let str : String = NSString(format: "%@" , (UserModel.share().getCurrentUser()?.phone)!) as String
//        alertView.title = "验证码发送到"  + " " + "\(str)"  + " " + "手机上\n" + " " + "请输入验证码"
//        alertView.addButton(withTitle: "确定")
//        alertView.addButton(withTitle: "取消")
//        alertView.delegate = self
//        alertView.show()
        
        let  model :BankListModel = self.dataArry[Int(ShareModel.share().shareData["number"]!)!] as BankListModel
        //  func unbindcard( vToken :String,bid: Int32,timestamp: Int64, phone :String, complete: CompleteBlock?, error: ErrorBlock?)
        //func unbindcard( vToken :String,bid: Int32,timestamp: Int64, phone :String,vCode:String, complete: CompleteBlock?, error: ErrorBlock?)
        AppAPIHelper.user().unbindcard(vToken: UserModel.share().codeToken, bid: Int32(model.bid), timestamp:  Int64(UserModel.share().timestamp) ,phone: (UserModel.share().getCurrentUser()?.phone)!, vCode:"", complete: { [weak self](result) -> ()? in
            
            
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
        }, error: self.errorBlockFunc())
        
//        let alertView = UIAlertView.init()
//        alertView.alertViewStyle = UIAlertViewStyle.plainTextInput // 密文
//          let str : String = NSString(format: "%@" , (UserModel.share().getCurrentUser()?.phone)!) as String
//        alertView.title = "验证码发送到"  + " " + "\(str)"  + " " + "手机上\n" + " " + "请输入验证码"
//        alertView.addButton(withTitle: "确定")
//        alertView.addButton(withTitle: "取消")
//        alertView.delegate = self
//        alertView.show()
            return nil
            }, error: self.errorBlockFunc())
    }
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    //输入密码 的代理方法
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        
        if buttonIndex==0{
            
            if buttonIndex==0{
                
//                let  model :BankListModel = self.dataArry[Int(ShareModel.share().shareData["number"]!)!] as BankListModel
                
//                AppAPIHelper.user().unbindcard(vToken: UserModel.share().codeToken, bid: Int32(model.bid), timestamp:  Int64(UserModel.share().timestamp) , phone: (UserModel.share().getCurrentUser()?.phone)!, vCode: (alertView.textField(at: 0)?.text)!, complete: { [weak self](result) -> ()? in
//                    
//                
//    //
//                    //                                                self?.tableView.reloadData()
//                                        if result != nil{
//                                            
//                                            let dic : NSDictionary = result as! NSDictionary
//                                            if (dic.object(forKey: "error") != nil){
//                                                let error : Int = dic.object(forKey: "error") as! Int
//                                                if error == -113{
//                                                
//                                                    SVProgressHUD.showError(withStatus: "验证码错误")
//                                                     self?.tableView.reloadData()
//                                                    return nil
//                                                }
//                                            }
//                                            self?.didRequest()
//                                            self?.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
//                                            self?.tableView.reloadData()
//                                                                }else{
//                    
//                                                                }
//                    
//                    return nil
//                    }, error: errorBlockFunc())
//                //                AppAPIHelper.user().unbindcard(bankId: model.bid, vCode: (alertView.textField(at: 0)?.text)!, complete: { [weak self](result) -> ()? in
//                //
//                //                    if result != nil{
//                //                        self?.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
//                //
//                //                        self?.tableView.reloadData()
//                //                    }else{
//                //
//                //                    }
//                //
//                //                    
//                //                    //            self?.didRequest()
//                //                    
//                //                    return nil
//                //                    }, error: errorBlockFunc())
//            }
        }
        
        }
    }
    
}
