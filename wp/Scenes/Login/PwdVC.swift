//
//  PwdVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

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
        performSegue(withIdentifier: NickNameVC.className(), sender: nil)
    }

}
