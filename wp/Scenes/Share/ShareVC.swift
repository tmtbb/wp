//
//  ShareVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class ShareVCCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var benifityLabel: UILabel!
    
}

class ShareVC: BaseListTableViewController {
    
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var weekBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    private var lastTypeBtn: UIButton?
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        didRequestComplete([""] as AnyObject)
    }
    //MARK: --UI
    func initUI() {
        tableView.rowHeight = 66
        rankTypeBtnTapped(dayBtn)
    
    }
    //MARK: --昨天之星，上周名人，月度名人
    @IBAction func rankTypeBtnTapped(_ sender: UIButton) {
        if let btn = lastTypeBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
        }
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
        lastTypeBtn = sender
    }
    
   
}
