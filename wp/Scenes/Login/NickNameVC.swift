//
//  NickNameVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
class NickNameVC: BaseTableViewController {
    
    @IBOutlet weak var nickNameText: UITextField!
    @IBOutlet weak var finishBtn: UIButton!

    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        //更新用户信息(登录)
        
    }
    //MARK: --UI
    func initUI() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        finishBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
    }
    //MARK: --Function
    @IBAction func finishBtnTapped(_ sender: Any) {
        if checkTextFieldEmpty([nickNameText]){
            AppAPIHelper.user().resetUserScreenName(screenName: nickNameText.text!, complete: { [weak self](result) -> ()? in
                UserModel.updateUser(info: { (result) -> ()? in
                    UserModel.share().currentUser?.nickname = self?.nickNameText.text
                })
                self?.dismissController()
                return nil
            }, error: errorBlockFunc())
        }
    }
    func popself(){
        dismissController()
    }

}
