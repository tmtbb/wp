//
//  ProductTypeView.swift
//  wp
//
//  Created by macbook air on 17/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion

class ProdectCell: UITableViewCell {
    
    //产品名字
    @IBOutlet weak var productName: UILabel!
    //现价
    @IBOutlet weak var nowPrice: UILabel!
    //今开
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var todayOpen: UILabel!
    //昨开
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var yesterdayOpen: UILabel!
    //最高
    @IBOutlet weak var hightLabel: UILabel!
    @IBOutlet weak var hightPrice: UILabel!
    //最底
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var lowPrice: UILabel!
    //变化价格
    @IBOutlet weak var changeLabel: UILabel!
    //变化百分比:计算
    @IBOutlet weak var changePer: UILabel!
    //设置阴影
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    
    //约束
    @IBOutlet weak var rightLayout: NSLayoutConstraint!
    @IBOutlet weak var todayOpenRight: NSLayoutConstraint!
    @IBOutlet weak var todayLabelRight: NSLayoutConstraint!
    @IBOutlet weak var hightLabelRight: NSLayoutConstraint!
    @IBOutlet weak var hightPriceRight: NSLayoutConstraint!
    @IBOutlet weak var nowPriceRight: NSLayoutConstraint!
    
    @IBOutlet weak var imageRight: NSLayoutConstraint!
    
    @IBOutlet weak var viewRigtLayout: NSLayoutConstraint!
    
    @IBOutlet weak var viewLeftLayout: NSLayoutConstraint!
    
    var kChartModel: KChartModel? {
        didSet{
            if kChartModel == nil {
                return
            }
            productName.text = String.init(format: "%@", kChartModel!.name)
            nowPrice.text = String.init(format: "%.4f", kChartModel!.currentPrice)
            todayOpen.text = String.init(format: "%.4f", kChartModel!.openingTodayPrice)
            yesterdayOpen.text = String.init(format: "%.4f", kChartModel!.closedYesterdayPrice)
            hightPrice.text = String.init(format: "%.4f", kChartModel!.highPrice)
            lowPrice.text = String.init(format: "%.4f", kChartModel!.lowPrice)
            changeLabel.text = String.init(format: "%.4f", kChartModel!.change)
            changePer.text = String.init(format: "%.2f%%", kChartModel!.pchg)
            lowPrice.dk_textColorPicker =  DKColorTable.shared().picker(withKey: AppConst.Color.buyDown)
            
            let colorKey = kChartModel!.change > 0 ? AppConst.Color.buyUp : AppConst.Color.buyDown
            changeLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            changePer.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            nowPrice.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            let iconName =  kChartModel!.change > 0 ? "upPrice" : "downPrice"
            iconImage.image = UIImage.init(named: iconName)
            iconImage.alpha = 1
            UIView.animate(withDuration: 2) { [weak self] in
                self?.iconImage.alpha = 0
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowRadius = 3
        viewShadow.layer.shadowOpacity = 0.3
        viewShadow.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
       
        let screenW = UIScreen.main.bounds.width / 375.0
        nowPrice.adjustsFontSizeToFitWidth = true
        todayOpen.adjustsFontSizeToFitWidth = true
        todayLabel.adjustsFontSizeToFitWidth = true
        yesterdayOpen.adjustsFontSizeToFitWidth = true
        yesterdayLabel.adjustsFontSizeToFitWidth = true
        hightPrice.adjustsFontSizeToFitWidth = true
        hightLabel.adjustsFontSizeToFitWidth = true
        lowPrice.adjustsFontSizeToFitWidth = true
        lowLabel.adjustsFontSizeToFitWidth = true
        changeLabel.adjustsFontSizeToFitWidth = true
        changePer.adjustsFontSizeToFitWidth = true
        
        if screenW < 1 {
            rightLayout.constant = 3
            todayOpenRight.constant = 1
            todayLabelRight.constant = 3
            hightLabelRight.constant = 2
            hightPriceRight.constant = 2
            nowPriceRight.constant = 3
            imageRight.constant = 1
            viewRigtLayout.constant = 6
            viewLeftLayout.constant = 6
        }
        if screenW > 1{
             rightLayout.constant = 18
             hightPriceRight.constant = 18
             hightPriceRight.constant = 16
        }
        
    }
}

