//
//  RegisterVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class RegisterVC: BaseTableViewController {
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var voiceCodeText: UITextField!
    @IBOutlet weak var voiceCodeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        
    }
    //获取图片验证码
    @IBAction func changeCodePicture(_ sender: UIButton) {
        
    }
    //获取声音验证码
    @IBAction func requestVoiceCode(_ sender: UIButton) {
        
    }
    //注册
    @IBAction func registerBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: PwdVC.className(), sender: nil)
    }
    //MARK: --UI
    func initUI() {
        
    }

}
