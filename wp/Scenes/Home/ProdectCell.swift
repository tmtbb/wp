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
    @IBOutlet weak var todayOpen: UILabel!
    //昨开
    @IBOutlet weak var yesterdayOpen: UILabel!
    //最高
    @IBOutlet weak var hightPrice: UILabel!
    //最底
    @IBOutlet weak var lowPrice: UILabel!
    //变化价格
    @IBOutlet weak var changeLabel: UILabel!
    //变化百分比:计算
    @IBOutlet weak var changePer: UILabel!
    
    @IBOutlet weak var layoutHightPrice: NSLayoutConstraint!
    
    @IBOutlet weak var layoutChangePer: NSLayoutConstraint!
    
    var kChartModel: KChartModel? {
        didSet{
            if kChartModel == nil {
                return
            }

           
            

            productName.text = "\(kChartModel!.goodType)"
            nowPrice.text = "\(kChartModel!.currentPrice)"
            todayOpen.text = "\(kChartModel!.openingTodayPrice)"
            yesterdayOpen.text = "\(kChartModel!.closedYesterdayPrice)"
            hightPrice.text = "\(kChartModel!.highPrice)"
            lowPrice.text = "\(kChartModel!.lowPrice)"
            changeLabel.text = "\(kChartModel!.change)"

            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenW = UIScreen.main.bounds.width / 375
        nowPrice.font = UIFont.systemFont(ofSize: 25 * screenW)
        todayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        yesterdayOpen.font = UIFont.systemFont(ofSize: 14 * screenW)
        hightPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        lowPrice.font = UIFont.systemFont(ofSize: 14 * screenW)
        changeLabel.font = UIFont.systemFont(ofSize: 13 * screenW)
        changePer.font = UIFont.systemFont(ofSize: 13 * screenW)
        
        if screenW < 1 {
            layoutHightPrice.constant = 10
            layoutChangePer.constant = 4
        }
    }  
}

