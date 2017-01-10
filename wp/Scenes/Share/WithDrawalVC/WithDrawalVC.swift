//
//  WithDrawalVC.swift
//  wp
//
//  Created by sum on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class WithDrawalVC: BaseTableViewController {
    
    // 发送验证码
    @IBOutlet weak var voiceCodeBtn: UIButton!
    // 定时器
    private var timer: Timer?
    // 时间
    private var codeTime = 60
    // 银行名
    @IBOutlet weak var bankTd: UITextField!
    // 支行名称
    @IBOutlet weak var branceTd: UITextField!
     // 地址
    @IBOutlet weak var addressTd: UITextField!
    //  姓名
    @IBOutlet weak var nameTd: UITextField!
    //  银行卡号
    @IBOutlet weak var bankNumberLb: UITextField!
    //  全部提现
    @IBOutlet weak var withDrawAll: UIButton!
    @IBOutlet weak var codeTd: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        title = "提现"
        
        // 设置 提现记录按钮
        initUI()
       
    }
    // MARK - 导航栏右侧
    func initUI(){
        // 设置 提现记录按钮
        let btn : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        btn.setTitle("提现记录", for:  UIControlState.normal)
        
        btn.addTarget(self, action: #selector(withDrawList), for: UIControlEvents.touchUpInside)
        
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: btn as UIView)
        self.navigationItem.rightBarButtonItem = barItem
      
        
        

    }
    // MARK: -进入提现列表
    func withDrawList(){
        
    self.performSegue(withIdentifier: "PushTolist", sender: nil)
    
    }
   
      //MARK: -提现
    @IBAction func withDraw(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SuccessWithdrawVC", sender: nil)
        
    }
    override func didRequest(_ pageIndex : Int) {
//        super.didRequestComplete([""] as AnyObject)
    
//
    }
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        self.voiceCodeBtn.isEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateBtnTitle), userInfo: nil, repeats: true)
    }
    func updateBtnTitle() {
        if codeTime == 0 {
            voiceCodeBtn.isEnabled = true
            voiceCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            return
        }
        voiceCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)S"
        voiceCodeBtn.setTitle(title, for: .normal)
    }
    


}
