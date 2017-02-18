//
//  WPWebViewController.swift
//  wp
//
//  Created by mu on 2017/2/17.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class WPWebViewController: UIViewController {

    let webView: UIWebView = UIWebView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        hideTabBarWithAnimationDuration()
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(64)
        }
        tabBarController?.tabBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
