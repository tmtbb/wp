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
        SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.size.width * 0.66
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
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
