//
//  MainTabBarViewController.swift
//  viossvc
//
//  Created by yaowang on 2016/10/27.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation
import SVProgressHUD

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {

    
    var select = Int ()
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = UIColor.white
        //友盟的帐号统计
        MobClick.profileSignIn(withPUID: "")
        select = 0
        let storyboardNames = ["Home","Deal","Share"]
        let titles = ["首页","交易","晒单"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])UnSelect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])Select")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: 0x666666)], for: .normal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: AppConst.Color.CMain], for: .selected)
            addChildViewController(controller!)
            
            delegate = self
        

        
        }

    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
    
        if tabBarController.selectedIndex == 2  {
            
            tabBarController.selectedIndex = select
            
//            SVProgressHUD.showError(withStatus: "敬请期待")
            
            let alert : UIAlertView = UIAlertView.init(title: "", message: "敬请期待", delegate: self, cancelButtonTitle: "确定")
          
            for  vi : UIView in alert.subviews {
                
                if vi.isKind(of: UILabel.self){
                    
                    let lab : UILabel = vi as! UILabel
                    
                    lab.font = UIFont.systemFont(ofSize: 20)
                
                }
                
            }
            alert.show()
            
//            return false
        }else{
        
            select =  tabBarController.selectedIndex
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
