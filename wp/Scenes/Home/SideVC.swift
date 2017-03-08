//
//  SideVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/22.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SideMenuController
class SideVC: SideMenuController, SideMenuControllerDelegate {

    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage.init(named:"1")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.size.width * 0.80
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .slideAnimation
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "centerSegue", sender: nil)
        performSegue(withIdentifier: "sideSegue", sender: nil)
        delegate = self
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        tabBarController?.tabBar.isHidden = true
    }

}

extension SideVC{
    public override static func initialize() {
        //tabbar的隐藏
        let originalSelector = #selector(SideMenuController.toggle)
        let swizzledSelector = #selector(SideVC.wpToggle)
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        
        let didsMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didsMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    }
    
    func wpToggle() {
//        if checkLogin() {
            self.wpToggle()
            super.toggle()
            tabBarController?.tabBar.isHidden = true
//        }
    }
}
