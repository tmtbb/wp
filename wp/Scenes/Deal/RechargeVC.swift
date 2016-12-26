//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class RechargeVC: BaseTableViewController {
    
    @IBOutlet weak var userIdText: UITextField!
    @IBOutlet weak var moneyText: UITextField!
    @IBOutlet weak var bankNumText: UITextField!
    @IBOutlet weak var rechargeMoneyLabel: UILabel!
    @IBOutlet weak var rechargeTypeLabel: UILabel!
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        
    }
    //MARK: --UI
    func initUI() {
        
    }
    //自动识别银行卡
    @IBAction func bankNumBtnTapped(_ sender: UIButton) {
        
    }
    //提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
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
