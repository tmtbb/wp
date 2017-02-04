//
//  AttentionUsController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class AttentionUsController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        let url = URL(string: "http://www.yundiantrip.com/")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
        translucent(clear: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
        
    }
    //MARK: -- 隐藏tabBar导航栏
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
       
        return true
        
    }
    
}
