//
//  DealDetailTableVC.swift
//  wp
//
//  Created by macbook air on 17/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class DealDetailTableVC: BaseTableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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


}
