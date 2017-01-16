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
    
    var model: KChartModel? {
        didSet{
            if model == nil {
                return
            }
            productName.text = model!.goodType
            nowPrice.text = "\(model!.currentPrice)"
            todayOpen.text = "\(model!.openingTodayPrice)"
            yesterdayOpen.text = "\(model!.closedYesterdayPrice)"
            hightPrice.text = "\(model!.highPrice)"
            lowPrice.text = "\(model!.lowPrice)"
            changeLabel.text = "\(model!.change)"
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenW = UIScreen.main.bounds.width / 375
        nowPrice.font = UIFont.systemFont(ofSize: 25 * screenW)
        todayOpen.font = UIFont.systemFont(ofSize: 13 * screenW)
        yesterdayOpen.font = UIFont.systemFont(ofSize: 13 * screenW)
        hightPrice.font = UIFont.systemFont(ofSize: 13 * screenW)
        lowPrice.font = UIFont.systemFont(ofSize: 13 * screenW)
        changeLabel.font = UIFont.systemFont(ofSize: 13 * screenW)
        changePer.font = UIFont.systemFont(ofSize: 13 * screenW)
        
        if screenW < 1 {
            layoutHightPrice.constant = 10
            layoutChangePer.constant = 8
        }
    }  
}

