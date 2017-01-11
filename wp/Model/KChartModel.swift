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
    var exchange_name: String = ""
    var platform_name: String = ""
    var currntPrice: String?
    var change: Double = 0.0
    var openPrice: Double = 0.0
    var closePrice: Double = 0.0
    var highPrice: Double = 0.0
    var lowPrice: Double = 0.0
    var priceTime: Int = 0
}
