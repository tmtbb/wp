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
    }
    
    func setupFooterView()->(UIView) {
        let footerView =  UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        footerView.backgroundColor = UIColor(rgbHex: 0xE9573E)
        let footerBtn = UIButton()
        footerBtn.setTitle("退出登录", for: .normal)
        footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        footerBtn.contentHorizontalAlignment = .center
        footerBtn.setTitleColor(UIColor(rgbHex: 0xFFFFFF), for: .normal)
        footerBtn.addTarget(self, action: #selector(quitEnterClick), for: .touchUpInside)
        footerView.addSubview(footerBtn)
        footerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(footerView).offset(15)
            make.right.equalTo(footerView).offset(15)
            make.top.bottom.equalTo(footerView)
        }
        return footerView
    }
    //监听退出登录按钮
    func quitEnterClick() {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
