//
//  MainTabBarViewController.swift
//  viossvc
//
//  Created by yaowang on 2016/10/27.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad();
        //友盟的帐号统计
        MobClick.profileSignIn(withPUID: "")
        
        let storyboardNames = ["Home","Deal","Share"]
        let titles = ["首页","交易","晒单"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.title = titles[index]
            addChildViewController(controller!)
        }
        
    }
    //友盟页面统计
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView(MainTabBarController.className())
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView(MainTabBarController.className())
    }
}
