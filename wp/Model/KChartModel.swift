//
//  KChartModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift

class KChartModelQuarter: KChartModel {
    
}

class KChartModelHour: KChartModel {
    
}

class KChartModelDay: KChartModel {
    
}

class KChartModel: Object {
    dynamic var name: String = ""
    dynamic var goodType: String = ""
    dynamic var exchangeName: String = ""
    dynamic var platformName: String = ""
    dynamic var currentPrice: Double = 0.0
    dynamic var change: Double = 0.0
    dynamic var openingTodayPrice: Double = 0.0
    dynamic var closedYesterdayPrice: Double = 0.0
    dynamic var highPrice: Double = 0.0
    dynamic var lowPrice: Double = 0.0
    dynamic var openPrice: Double = 0.0
    dynamic var closePrice: Double = 0.0
    dynamic var priceTime: Int = 0
    dynamic var onlyKey: String = ""
    override static func primaryKey() -> String{
        return "onlyKey"
    }
}




