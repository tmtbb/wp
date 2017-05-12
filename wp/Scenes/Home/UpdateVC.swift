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
    }

    //确认
    @IBAction func sureBtnTapped(_ sender: Any) {
        dismissController()
    }
}
