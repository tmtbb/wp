//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
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
            //            AppAPIHelper.user().unbindcard(bankId: Int32(model.bid), vCode: 2000, complete: { (result) -> ()? in
            //
            //
            //                return nil
            //            }, error: errorBlockFunc())
            
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
        return false
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
        
        
        
        let alertView = UIAlertView.init()
        alertView.alertViewStyle = UIAlertViewStyle.plainTextInput // 密文
        alertView.title = "请输入验证码"
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
                AppAPIHelper.user().unbindcard(bankId: model.bid, vCode: (alertView.textField(at: 0)?.text)!, complete: { [weak self](result) -> ()? in
                    
                    if result != nil{
                        self?.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
                        
                        self?.tableView.reloadData()
                    }else{
                        
                    }
                    
                    
                    //            self?.didRequest()
                    
                    return nil
                    }, error: errorBlockFunc())
            }
        }
        
        
    }
    
}
