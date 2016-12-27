//
//  BuyVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class BuyVC: BaseTableViewController {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var waveLabel: UILabel!
    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    //购买白银规格
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var midlleBtn: UIButton!
    @IBOutlet weak var highBtn: UIButton!
    @IBOutlet weak var totalBtn: UIButton!
    
    @IBOutlet weak var firstWaveBtn: UIButton!
    @IBOutlet weak var firstLostBtn: UIButton!
    @IBOutlet weak var firstWinBtn: UIButton!
    
    @IBOutlet weak var sureBtn: UIButton!
    private var lastBuyBtn: UIButton?
    //盈损波动
    private var lastWaveBtn: UIButton?
    private var lastWinBtn: UIButton?
    private var lastLostBtn: UIButton?
    //推单/晒单
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var buildBtn: UIButton!
    private var lastDealBtn: UIButton?
    
    
    var dealColor:UIColor?
    
    
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
        dealColor =  DealModel.share().dealUp ? AppConst.Color.CMain : AppConst.Color.CGreen
        let dealTitle = DealModel.share().dealUp ? "买涨" : "买跌"
        title = dealTitle
        lineView.backgroundColor = dealColor
        priceLabel.textColor = dealColor
        waveLabel.textColor = dealColor
        sureBtn.backgroundColor = dealColor
        sureBtn.setTitle(dealTitle, for: .normal)
        
        countBtnTapped(lowBtn)
        waveBtnTapped(firstWaveBtn)
        stopLostBtnTapped(firstLostBtn)
        stopWinBtnTapped(firstWinBtn)
        buildDealBtnTapped(buildBtn)
    }
    //MARK: --购买白银规格
    @IBAction func countBtnTapped(_ sender: UIButton) {
        if let btn = lastBuyBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastBuyBtn = sender
    }
    //MARK: --盈动波动
    @IBAction func waveBtnTapped(_ sender: UIButton) {
        if let btn = lastWaveBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastWaveBtn = sender
    }
    //MARK: --止损止赢
    @IBAction func stopLostBtnTapped(_ sender: UIButton) {
        if let btn = lastLostBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastLostBtn = sender
    }
    @IBAction func stopWinBtnTapped(_ sender: UIButton) {
        if let btn = lastWinBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastWinBtn = sender
    }
    //MARK: --建仓推单
    @IBAction func buildDealBtnTapped(_ sender: UIButton) {
        if let btn = lastDealBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastDealBtn = sender
    }
    //MARK: --止赢晒单
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        if let btn = lastDealBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastDealBtn = sender
    }
    
    
}
