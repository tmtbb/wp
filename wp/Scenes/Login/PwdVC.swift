//
//  PwdVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class PwdVC: BaseTableViewController {

    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var repwdText: UITextField!
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
    //MARK: --UI
    func initUI() {
        
    }
    //MARK: --Function
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if checkTextFieldEmpty([pwdText,repwdText]){
            if pwdText.text != repwdText.text{
                SVProgressHUD.showErrorMessage(ErrorMessage: "两次输入密码不一致，请重新输入", ForDuration: 1.5, completion: { 
                    self.pwdText.text = ""
                    self.repwdText.text = ""
                })
                return
            }
            
            AppAPIHelper.login().repwd(pwd: pwdText.text, complete: { [weak self](result) -> ()? in
                self?.performSegue(withIdentifier: NickNameVC.className(), sender: nil)
            }, error: errorBlockFunc())
        }
    }

}
