//
//  MyMessageController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class MyMessageController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        // Do any additional setup after loading the view.
        translucent(clear: false)
        tableView.tableFooterView = setupFooterView()
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 15, y: 5, width: 38, height: 38)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(backDidClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
    }
    func backDidClick() {
        navigationController?.popToRootViewController(animated: true)
    }
    func setupFooterView()->(UIView) {
        let footerView =  UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let footerBtn = UIButton()
        footerBtn.backgroundColor = UIColor(rgbHex: 0xE9573E)
        footerBtn.layer.cornerRadius = 10
        footerBtn.layer.masksToBounds = true
        footerBtn.setTitle("退出登录", for: .normal)
        footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        footerBtn.contentHorizontalAlignment = .center
        footerBtn.setTitleColor(UIColor(rgbHex: 0xFFFFFF), for: .normal)
        footerBtn.addTarget(self, action: #selector(quitEnterClick), for: .touchUpInside)
        footerView.addSubview(footerBtn)
        footerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(footerView).offset(15)
            make.right.equalTo(footerView).offset(-15)
            make.top.bottom.equalTo(footerView)
        }
        return footerView
    }
    //监听退出登录按钮
    func quitEnterClick() {
        userLogout()
        navigationController?.popToRootViewController(animated: true)
        print("退出登录")
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if  section == 2 {
            return 10
        }
        if section == 4 {
            return 50
        }
        return 0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        translucent(clear: true)
        showTabBarWithAnimationDuration()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
    //MARK: -- 隐藏tabBar导航栏
    func hideTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        
        var tabFrame = tabBar?.frame
        tabFrame?.origin.y = (window?.bounds)!.maxY
        tabBar?.frame = tabFrame!
        content?.frame = (window?.bounds)!
    }
    //MARK: -- 展示tabBar导航栏
    func showTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        var tabFrame = tabBar?.frame
        tabFrame?.origin.y = (window?.bounds)!.maxY - ((tabBar?.frame)?.height)!
        tabBar?.frame = tabFrame!
        
        var contentFrame = content?.frame
        contentFrame?.size.height -= (tabFrame?.size.height)!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            performSegue(withIdentifier: DealPasswordVC.className(), sender: nil)
        }
        if indexPath.section == 4{
             performSegue(withIdentifier: EnterPasswordVC.className(), sender: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
