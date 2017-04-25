//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import SVProgressHUD

class SelectBankVC: BaseListTableViewController {
    //定义选择的行数
    var selectNumber = Int()
    
    var dataArry : [BankListModel] = []
    
    var finishBtn = UIButton()
    override func viewDidLoad() {
        //默认开始选择的是第一行
        selectNumber = 100000
        self.title = "我的银行卡"
        super.viewDidLoad()
        
        initUI()
    }
    func initUI(){
        // 设置 提现记录按钮
        finishBtn = UIButton.init(frame: CGRect.init(x: 30, y: 0, width: 40, height: 30))
        finishBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        finishBtn.setTitle("完成", for:  UIControlState.normal)
        
        finishBtn.addTarget(self, action: #selector(finish), for: UIControlEvents.touchUpInside)
        finishBtn.isHidden = true
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: finishBtn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        
    }
     //MARK: 点击完成按钮
    func finish(){
        
        //做数组保护  不等于1000的时候来进行充值
        if selectNumber != 100000 {
            
            let  Model : BankListModel = self.dataArry[selectNumber]
            
            ShareModel.share().selectBank  =  Model
            
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        self.didRequest()
    }
     //MARK: --网络请求
    override func didRequest() {
        AppAPIHelper.user().bankcardList(complete: { [weak self](result) -> ()? in
            
            if let object = result {
                let Model : BankModel = object as! BankModel
                self?.didRequestComplete(Model.cardList as AnyObject)
                self?.dataArry = Model.cardList!
                self?.tableView.reloadData()
            }else {
                self?.didRequestComplete(nil)
            }
            
            return nil
            }, error: errorBlockFunc())
        
        
    }
     //MARK: --tableView的代理和数据源的设置
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArry.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 15
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : BindingBankVCCell = tableView.dequeueReusableCell(withIdentifier: "BankCardVCCell") as! BindingBankVCCell
        let  Model : BankListModel = self.dataArry[indexPath.section]
        cell.update(Model.self)
        if indexPath.section == selectNumber {
            cell.contentView.alpha =  1
            cell.accessoryType =  UITableViewCellAccessoryType .checkmark
        }else{
            cell.contentView.alpha =  0.5
            cell.accessoryType =  .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectNumber = indexPath.section
        tableView.reloadData()
        finishBtn.isHidden = false
   }
    //MARK: 实现银行卡左滑删除的代理
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index  in
            ShareModel.share().shareData["number"] = "\(indexPath.section)"
            self.UnbindCard(number: indexPath.section)
            self.dataArry.remove(at: Int(ShareModel.share().shareData["number"]!)!)
            tableView.reloadData()
        }
        share.backgroundColor = UIColor.red
        return [share]
    }
    //MARK: 解绑逻辑
    func UnbindCard ( number: Int) {
        let index = Int(ShareModel.share().shareData["number"]!)
        let  model :BankListModel = self.dataArry[index!]
        let param = UnBingCardParam()
        param.bankCardId = Int(model.bid)
        AppAPIHelper.user().unbindcard(param: param, complete: { [weak self](result) -> ()? in
            if result != nil{
                self?.didRequest()
            }
            return nil
        }, error: self.errorBlockFunc())
        
//        AppAPIHelper.user().unbindcard(vToken: UserModel.share().codeToken, bid: Int32(model.bid), timestamp:  Int64(UserModel.share().timestamp) ,phone: (UserModel.share().getCurrentUser()?.phone)!, vCode:"", complete: { [weak self](result) -> ()? in
//            if result != nil{
//                self?.didRequest()
//            }
//            return nil
//        }, error: self.errorBlockFunc())
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    
    
}
