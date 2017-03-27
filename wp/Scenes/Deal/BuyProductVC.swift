//
//  BuyProductVC.swift
//  wp
//
//  Created by mu on 2017/2/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
import SVProgressHUD
class BuyProductVC: UIViewController {
    
    
    @IBOutlet weak var buyCountLabel: UILabel!
    @IBOutlet weak var countSlider: UISlider!
    @IBOutlet weak var minCountLabel: UILabel!
    @IBOutlet weak var maxCountLabel: UILabel!
    @IBOutlet weak var dingjinLabel: UILabel!
    @IBOutlet weak var dingjinPLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var huoyunBtn: UIButton!
    @IBOutlet weak var doubleBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var countBtn: UIButton!
    @IBOutlet weak var countConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cangWeiLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var resultBlock: CompleteBlock?
    
    enum BuyResultType: Int {
        case success = 0
        case cancel = 1
        case lessMoney = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        requestShippingSpaceInfo()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePrice), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countSlider.value = 3.0
        changeCount(countSlider)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    func requestShippingSpaceInfo() {
        
        let positionParm = PositionParam()
        positionParm.gid = DealModel.share().buyProduct!.id
        AppAPIHelper.deal().position(param: positionParm, complete: { [weak self](result) -> ()? in
            if let model = result as? ProductPositionModel {
                self?.cangWeiLabel.text = "当前舱位航班: \(model.name)"
            }
            return nil
        }, error: errorBlockFunc())
        
    }
    
    func initUI() {
        view.backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = 3
        buyCountLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        countBtn.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.main), for: .normal)
        countSlider.setThumbImage(UIImage.init(named: "buyPoint"), for: .normal)
        minCountLabel.text = "\(DealModel.share().buyProduct!.minLot)"
        maxCountLabel.text = "\(DealModel.share().buyProduct!.maxLot)"
        buyCountLabel.text = "当前选择手数\(DealModel.share().buyProduct!.minLot)"
        countBtn.setTitle("\(DealModel.share().buyProduct?.minLot)", for: .normal)
        buyBtn.setTitle(DealModel.share().dealUp ? "买入" : "卖出", for: .normal)
        
        let colorKey = DealModel.share().dealUp ? AppConst.Color.buyUp : AppConst.Color.buyDown
        dingjinLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        dingjinPLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        moneyLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        feeLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        buyBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        
        let selectBtnName = DealModel.share().dealUp ? "upSelect" : "downSelect"
        huoyunBtn.setImage(UIImage.init(named: selectBtnName), for: .selected)
        doubleBtn.setImage(UIImage.init(named: selectBtnName), for: .selected)
        selectTypeBtnTapped(doubleBtn)
        
//        let contentHeight: CGFloat = DealModel.share().dealUp ?  330 : 300
//        heightConstraint.constant = contentHeight
//        cangWeiLabel.text = ""
    }
    
    func updatePrice() {
        changeCount(countSlider)
    }
    
    @IBAction func changeCount(_ sender: UISlider) {
        let value = sender.value
        let sliderWidth = countSlider.frame.width
        countConstraint.constant = sliderWidth * CGFloat(value) / 10.0 - 34
        countBtn.setTitle("\(Int(value))", for: .normal)
        buyCountLabel.text = "当前选择手数 \(Int(value))"
        let dingjin = Double(Int(value))*DealModel.share().buyProduct!.price
        dingjinLabel.text = String.init(format: "%.2f", dingjin)
        moneyLabel.text = String.init(format: "%.2f", Double(dingjin*(1 - DealModel.share().buyProduct!.openChargeFee)))
        feeLabel.text = "\(DealModel.share().buyProduct!.openChargeFee*100)%"
    }
    
    @IBAction func selectTypeBtnTapped(_ sender: UIButton) {
        sender.isSelected = true
        if huoyunBtn == sender {
            doubleBtn.isSelected = false
        }else{
            huoyunBtn.isSelected = false
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        dismissController()
    }
    
    @IBAction func buyBtnTapped(_ sender: UIButton) {
        if Double(dingjinLabel.text!)! > UserModel.share().currentUser!.balance && resultBlock != nil {
            resultBlock!(BuyResultType.lessMoney as AnyObject)
//            dismissController()
            return
        }
        view.isUserInteractionEnabled = false
        SVProgressHUD.showProgressMessage(ProgressMessage: "交易中...")
        let buyModel: BuildDealParam = BuildDealParam()
        buyModel.codeId = DealModel.share().buyProduct!.id
        buyModel.buySell = DealModel.share().dealUp ? 1 : -1
        buyModel.amount = Int(countSlider.value)
        buyModel.isDeferred = DealModel.share().buyModel.isDeferred

        AppAPIHelper.deal().buildDeal(model: buyModel, complete: { [weak self](result) -> ()? in
            SVProgressHUD.dismiss()
            self?.view.isUserInteractionEnabled = true
            if let product: PositionModel = result as? PositionModel{
                self?.dismissController()
                if self?.resultBlock != nil{
                    self?.resultBlock!(BuyResultType.success as AnyObject)
                }
                DealModel.cachePosition(position: product)
                YD_CountDownHelper.shared.reStart()
            }
            return nil
        }) { (error) -> ()? in
            self.didRequestError(error)
            self.view.isUserInteractionEnabled = true
            return nil
        }
        
        
    }
    
}
