//
//  ProductTypeView.swift
//  wp
//
//  Created by macbook air on 17/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit



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

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenW = UIScreen.main.bounds.width / 375.0
//        nowPrice.font = UIFont.systemFont(ofSize: 32 * screenW)
        nowPrice.adjustsFontSizeToFitWidth = true
//        todayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        todayOpen.adjustsFontSizeToFitWidth = true
//        todayLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        todayLabel.adjustsFontSizeToFitWidth = true
//        yesterdayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        yesterdayOpen.adjustsFontSizeToFitWidth = true
//        yesterdayLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        yesterdayLabel.adjustsFontSizeToFitWidth = true
//        hightPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        hightPrice.adjustsFontSizeToFitWidth = true
//        hightLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        hightLabel.adjustsFontSizeToFitWidth = true
//        lowPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        lowPrice.adjustsFontSizeToFitWidth = true
//        lowLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        lowLabel.adjustsFontSizeToFitWidth = true
//        changeLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        changeLabel.adjustsFontSizeToFitWidth = true
//        changePer.font = UIFont.systemFont(ofSize: 12 * screenW)
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
        
    }
}

