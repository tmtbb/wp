//
//  BuyVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class BuyVC: BaseTableViewController {
    
    @IBOutlet weak var dealCountLabel: UILabel!
    @IBOutlet weak var dealPriceLabel: UILabel!
    @IBOutlet weak var dealNameLabel: UILabel!
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var waveLabel: UILabel!
    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var StopView: UIView!
    //购买白银规格
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var midlleBtn: UIButton!
    @IBOutlet weak var highBtn: UIButton!
    @IBOutlet weak var totalBtn: UIButton!
    
    @IBOutlet weak var firstWaveBtn: UIButton!
    @IBOutlet weak var firstLostBtn: UIButton!
    @IBOutlet weak var firstWinBtn: UIButton!
    
    @IBOutlet weak var footView: UIView!
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
        title = DealModel.share().isDealDetail ? "修改持仓参数" : dealTitle
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
        
        footView.isHidden = DealModel.share().isDealDetail
 
//        lowBtn.setTitle("\((DealModel.share().selectProduct?.profitPerUnit)!)元\n100g", for: .normal)
//        midlleBtn.setTitle("\((DealModel.share().selectProduct?.profitPerUnit)!*10)元\n1000g", for: .normal)
//        highBtn.setTitle("\((DealModel.share().selectProduct?.profitPerUnit)!*50)元\n5000g", for: .normal)
//        
//        if let dealModel = DealModel.share().selectDealModel{
//            dealNameLabel.text = dealModel.name
//            dealPriceLabel.text = "\(dealModel.closePrice)"
//            dealCountLabel.text = "\((DealModel.share().selectProduct?.profitPerUnit)! * Double(dealModel.amount))元\n\(100*dealModel.amount)g"
//           
//            let limittag = Int((dealModel.limit - 1)*10)
//            let limitbtn: UIButton = StopView.viewWithTag(100+limittag) as! UIButton
//            stopWinBtnTapped(limitbtn)
//            
//            
//            let stopTag = Int((dealModel.stop - 1)*10)
//            let stopbtn: UIButton = StopView.viewWithTag(200+stopTag) as! UIButton
//            stopLostBtnTapped(stopbtn)
//        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DealModel.share().isDealDetail ? 0 : 1
        case 1:
            return DealModel.share().isDealDetail ? 1 : 0
        case 2:
            return DealModel.share().isDealDetail ? 0 : 1
        case 3:
            return 6
        case 4:
            return DealModel.share().isDealDetail ? 1 : 0
        default:
            return 0
        }
    }
    //MARK: --我的资产
    @IBAction func jumpToMyWallet(_ sender: AnyObject) {
        if checkLogin(){
            let storyboard = UIStoryboard.init(name: "Share", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: MyWealtVC.className())
            navigationController?.pushViewController(controller, animated: true)
        }
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
        
        if sender == lowBtn {
            DealModel.share().buyModel.amount = 1
        }else if sender == midlleBtn{
            DealModel.share().buyModel.amount = 10
        }else if sender == highBtn{
            DealModel.share().buyModel.amount = 50
        }else{
            DealModel.share().buyModel.amount = (DealModel.share().selectProduct?.maxLot)!
        }
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
        DealModel.share().buyModel.stop = Double(sender.tag) - 100 / 10
    }
    @IBAction func stopWinBtnTapped(_ sender: UIButton) {
        if let btn = lastWinBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        sender.isSelected = true
        sender.backgroundColor = dealColor
        lastWinBtn = sender
        DealModel.share().buyModel.stop = Double(sender.tag) - 200 / 10
    }
    //MARK: --建仓推单/止赢晒单
    @IBAction func buildDealBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? dealColor : UIColor.init(rgbHex: 0xe6e9ed)
        
    }
    //MARK: --买涨/买跌(建仓)
    @IBAction func cancelBtnTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buyBtnTapped(_ sender: Any) {
//        DealModel.share().buyModel.id = UserModel.currentUserId
//        DealModel.share().buyModel.token = UserModel.token ?? ""
//        DealModel.share().buyModel.code = (DealModel.share().selectDealModel?.code)!
//        DealModel.share().buyModel.buySell = 1
//        AppAPIHelper.deal().buildDeal(model: , complete: { [weak self](result) -> ()? in
//            self?.navigationController?.popViewController(animated: true)
//            return nil
//        }, error: errorBlockFunc())
    }
    //MARK: --修改持仓
    @IBAction func changeBtnTapped(_ sender: Any) {
        AppAPIHelper.deal().changeDeal(model: DealModel.share().buyModel, complete: { [weak self](result) -> ()? in
            
            return nil
        }, error: errorBlockFunc())
    }
}
