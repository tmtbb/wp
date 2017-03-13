//
//  KChartModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift






class KChartModel: Object {
    dynamic var symbol: String = ""
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
    dynamic var pchg: Double = 0
    dynamic var systemTime:Int64 = 0
    override static func primaryKey() -> String{
        return "onlyKey"
    }
}

class KLineChartModel: KChartModel {
    dynamic var chartType: Int = -1
}


class ChartModel: BaseModel {
    var priceinfo: [KLineChartModel]! = []
    var chartType: Int = -1
    
    class func priceinfoModelClass() -> AnyClass {
        return KLineChartModel.classForCoder()
    }
}

class ProductPositionModel: BaseModel {
    var gid = 0
    var id = 0
    var name = ""
    
    
}
