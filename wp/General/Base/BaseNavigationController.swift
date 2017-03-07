//
//  BaseNavigationController.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate ,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
      interactivePopGestureRecognizer?.isEnabled = true
      self.interactivePopGestureRecognizer?.delegate = self
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.shadowImage = UIImage.init(named: "nav_clear")
        self.navigationBar.setBackgroundImage(UIImage.init(named: "nav_main"), for: .any, barMetrics: .default)
    }
    //MARK: 重新写左面的导航
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: true)

        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        
        btn.setTitle("", for: UIControlState.normal)
        
        btn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal )
    
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        
        btn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        viewController.navigationItem.leftBarButtonItem = barItem
        interactivePopGestureRecognizer?.delegate = self
    }
    func popself(){
        if viewControllers.count > 1 {
            self.popViewController(animated: true)
        }else{
            dismissController()
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (viewControllers.count <= 1)
        {
            return false;
        }
        
        return true;
    }
   
}
