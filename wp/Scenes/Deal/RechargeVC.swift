//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class RechargeVC: BaseTableViewController {
    
    /**用户账号**/
    @IBOutlet weak var userIdText: UITextField!
    
    /**余额**/
    @IBOutlet weak var moneyText: UITextField!
    
    /**银行卡号**/
    @IBOutlet weak var bankNumText: UITextField!
    
    /**充值金额**/
    @IBOutlet weak var rechargeMoneyLabel: UILabel!
    
    /**充值方式**/
    @IBOutlet weak var rechargeTypeLabel: UILabel!
    
    /**自定义cell**/
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!
    /**自定义cell**/
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!
    
    /**用户账号**/
    var dataModel : RechargeDetailModel!
    
    //网络请求
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { [weak self](result) -> ()? in
            
            self?.dataModel = result as! RechargeDetailModel!
            
            let str  = (self?.dataModel.depositName)!
             print(str)
        
            return nil
        }, error: errorBlockFunc())
        
    }
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "充值"
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
          didRequest()
    
    }
    
    //MARK: --UI
    func initUI() {
      
    }
    //自动识别银行卡
    @IBAction func bankNumBtnTapped(_ sender: UIButton) {
        
    }
    //提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        let  story  =  UIStoryboard.init(name: "Share", bundle: nil)
        
        let new  = story.instantiateViewController(withIdentifier: "MyWealtVC") 
        
        self.navigationController?.pushViewController(new, animated: true)
        
        
    }
    //table's datasource and delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        if cell == rechargeMoneyCell {
            
            return
        }
        
        if cell == rechargeTypeCell {
            
            return
        }
    }
}
//MARK: 选择支付方式 的view
class ChoosePayType: UIView {
    
        override init(frame: CGRect) {
  
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
