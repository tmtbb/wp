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
    
    @IBOutlet weak var layoutWidth: NSLayoutConstraint!
    
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
            changePer.text = String.init(format: "%.2f%", kChartModel!.change/(kChartModel?.currentPrice)!)
            
            let colorKey = kChartModel!.change > 0 ? AppConst.Color.buyUp : AppConst.Color.buyDown
            changeLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            changePer.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            productName.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
            

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenW = UIScreen.main.bounds.width / 375.0
        nowPrice.font = UIFont.systemFont(ofSize: 26 * screenW)
        nowPrice.sizeToFit()
        todayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        todayOpen.sizeToFit()
        todayLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        todayLabel.sizeToFit()
        yesterdayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        yesterdayOpen.sizeToFit()
        yesterdayLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        yesterdayLabel.sizeToFit()
        hightPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        hightPrice.sizeToFit()
        hightLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        hightLabel.sizeToFit()
        lowPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        lowPrice.sizeToFit()
        lowLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        lowLabel.sizeToFit()
        changeLabel.font = UIFont.systemFont(ofSize: 12 * screenW)
        changeLabel.sizeToFit()
        changePer.font = UIFont.systemFont(ofSize: 12 * screenW)
        changePer.sizeToFit()
//
//        if screenW < 1 {
//            layoutWidth.constant = 0
//            
//        }
//        else{
//            layoutWidth.constant = 3
//        }
    }
}

