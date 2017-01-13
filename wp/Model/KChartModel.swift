//
//  KChartModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class KChartModel: BaseModel {
    var goodType: String = ""
    var exchangeName: String = ""
    var platformName: String = ""
    var currntPrice: Double = 0.0
    var change: Double = 0.0
    var openingTodayPrice: Double = 0.0
    var closedYesterdayPrice: Double = 0.0
    var highPrice: Double = 0.0
    var lowPrice: Double = 0.0
    var priceTime: Double = 0
}
