//
//  UpdateVC.swift
//  wp
//
//  Created by mu on 2017/5/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion

class UpdateVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.masksToBounds = true
        sureBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        timeLabel.text = "发布时间:\(UserModel.share().updateParam.newAppReleaseTime)"
        versionLabel.text = "版本:\(UserModel.share().updateParam.newAppVersionName)"
        mLabel.text = "大小:\(UserModel.share().updateParam.newAppSize)M"
        contentLabel.text = UserModel.share().updateParam.newAppUpdateDesc
    }

    //确认
    @IBAction func sureBtnTapped(_ sender: Any) {
        if UserModel.share().updateParam.isForceUpdate == 0 {
            
            UIApplication.shared.openURL(URL.init(string: "https://itunes.apple.com/us/app/%E8%88%AA%E6%8A%95%E5%AE%9D/id1238069410?l=zh&ls=1&mt=8")!)
            return
        }
        dismissController()
    }
}
