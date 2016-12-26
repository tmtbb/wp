//
//  DealVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealVC: BaseTableViewController {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var myQuanLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var upDownView: UIView!
    @IBOutlet weak var winRateConstraint: NSLayoutConstraint!
    @IBOutlet weak var kLineView: KLineView!
    private var klineBtn: UIButton?
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    //MARK: --DATA
    func initData() {
        
    }
    
    //MARK: --UI
    func initUI() {
        
    }
    //MARK: --KlineView and Btns
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        if let btn = klineBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        
        kLineView.selectIndex = sender.tag
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
    
        klineBtn = sender
    }
    
    //MARK: --买涨/买跌
    @IBAction func dealBtnTapped(_ sender: UIButton) {
        DealModel.share().dealUp = sender.tag == 1 
    }
    
  
}
