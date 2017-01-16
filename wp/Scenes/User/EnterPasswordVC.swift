//
//  EnterPasswordVC.swift
//  wp
//
//  Created by macbook air on 17/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class EnterPasswordVC: UIViewController {

    @IBOutlet weak var oldEnterPassword: UITextField!
    
    @IBOutlet weak var newEnterPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //确定按钮
    @IBAction func ensureBtn(_ sender: Any) {
        
        //        //重置密码
        //        if UserModel.share().forgetPwd {
        //            SVProgressHUD.showProgressMessage(ProgressMessage: "重置中...")
        //            let password = ((pwdText.text! + AppConst.sha256Key).sha256()+UserModel.share().phone!).sha256()
        //            AppAPIHelper.login().repwd(phone: UserModel.share().phone!, type: 0,  pwd: password, code: UserModel.share().code!, complete: { [weak self](result) -> ()? in
        //                SVProgressHUD.showWainningMessage(WainningMessage: "重置成功", ForDuration: 1, completion: nil)
        //                self?.navigationController?.popToRootViewController(animated: true)
        //                return nil
        //                }, error: errorBlockFunc())
        //            return
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
