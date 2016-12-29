//
//  NickNameVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

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
        
    }
    //MARK: --UI
    func initUI() {
        
    }
    //MARK: --Function
    @IBAction func finishBtnTapped(_ sender: Any) {
        if checkTextFieldEmpty([nickNameText]){
            let user = UserInfo()
            AppAPIHelper.user().userInfo(user: user , complete: { [weak self](result) -> ()? in
                self?.dismissController()
            }, error: errorBlockFunc())
        }
    }

}
