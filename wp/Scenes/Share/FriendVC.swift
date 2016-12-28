//
//  FriendVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
class FriendVC: BaseTableViewController {
    //头部
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var wainningText: UITextField!
    //总收益
    @IBOutlet weak var totalBenifityBtn: UIButton!
    @IBOutlet weak var totalBenifityLabel: UILabel!
    @IBOutlet weak var monthBenifityLabel: UILabel!
    @IBOutlet weak var weekBenifityLabel: UILabel!
    @IBOutlet weak var benifityBarChart: BarChartView!
    //好友晒单
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var monthShareLabel: UILabel!
    @IBOutlet weak var weekShareLabel: UILabel!
    @IBOutlet weak var dayShareLabel: UILabel!
    private var index: NSInteger = 0
    private var lastTypeBtn: UIButton?
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        translucent(clear: false)
    }
    //MARK: --DATA
    func initData() {
        itemBtnTapped(totalBenifityBtn)
    }
    //MARK: --UI
    func initUI() {
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        
        
    }
    //MARK: --总收益/好友晒单/好友推单
    @IBAction func itemBtnTapped(_ sender: UIButton) {
        if let btn = lastTypeBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
        }
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
        lastTypeBtn = sender
        index = sender.tag
        tableView.reloadData()
    }
    //MARK: --推单通知
    @IBAction func recommendBtnTapped(_ sender: Any) {
        
    }
    //MARK: --Tableview's delegate and datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == index{
            return section == 2 ? 3:2
        }else{
            return 0
        }
    }
}
