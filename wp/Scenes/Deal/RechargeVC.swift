//
//  RechargeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class RechargeVC: BaseTableViewController {
    
    //用户账户
    @IBOutlet weak var userIdText: UITextField!
    
    //余额
    @IBOutlet weak var moneyText: UITextField!
    
    //银行卡号
    @IBOutlet weak var bankNumText: UITextField!
    
    //充值金额
    @IBOutlet weak var rechargeMoneyLabel: UITextField!
    
    //充值方式*
    @IBOutlet weak var rechargeTypeLabel: UILabel!
    
    //自定义cell
    @IBOutlet weak var rechargeMoneyCell: UITableViewCell!
    //自定义cell
    @IBOutlet weak var rechargeTypeCell: UITableViewCell!
    
    // 来用来判断刷新几个区
    var selectRow : Bool!
    
    //网络请求
    override func didRequest() {
        
        //        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { [weak self](result) -> ()? in
        //
        //
        //            print(str)
        //
        //            return nil
        //            }, error: errorBlockFunc())
        
    }
       //MARK: --UI
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ShareModel().selectType), object: nil)
    }
    func initUI(){
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        btn.setTitle("充值记录", for:  UIControlState.normal)
        
        btn.addTarget(self, action: #selector(rechargeList), for: UIControlEvents.touchUpInside)
        
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
        
        // 监听value变化
        
        NotificationCenter.default.addObserver(self, selector: #selector(vaulechange(_:)), name: NSNotification.Name(rawValue: ShareModel().selectType), object: nil)
      
        
        
    }
    func vaulechange(_ notice: NSNotification) {
        
         let errorCode: Int = (notice.object as? Int)!
        
          print(errorCode)
        
        
    }
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
    //MARK: -充值方式
    
    //MARK: -进入绑定银行卡
    @IBAction func addBank(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard.init(name: "Share", bundle: nil)
        
        let BindingBankVC :BindingBankVC = storyBoard.instantiateViewController(withIdentifier: "BindingBankVC") as! BindingBankVC
        
        self.navigationController?.pushViewController(BindingBankVC, animated: true)
        
        
    }
    //MARK -提交
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        let  story  =  UIStoryboard.init(name: "Share", bundle: nil)
        
        let new  = story.instantiateViewController(withIdentifier: "MyWealtVC")
        
        self.navigationController?.pushViewController(new, animated: true)
        
        
    }
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
                selectRow = !selectRow
                 tableView.reloadSections(IndexSet.init(integer: 2), with: UITableViewRowAnimation.fade)
            }
            
        }
        
    }
}



