//
//  HomeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Alamofire
class HomeVC: BaseTableViewController {
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    //MARK: --DATA
    func initData() {
        
    }
    //MARK: --UI
    func initUI() {
        let homeStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        let loginNav:BaseNavigationController = homeStoryboard.instantiateViewController(withIdentifier: "LoginNav") as! BaseNavigationController
//        let loginVC = loginNav.viewControllers.first
        present(loginNav, animated: true, completion: nil)
    }
    
}
