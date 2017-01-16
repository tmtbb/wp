//
//  DealParam.swift
//  wp
//
//  Created by 木柳 on 2017/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class KChartParam: DealModel {
    var goodType: String = ""	//商品类型
    var exchangeName: String = ""	//交易所
    var platformName: String = ""	//平台名称
    var chartType: Int = 0	//K线类型	1-1分钟K线，2-5分K线，3-15分K线，4-30分K线，5-60分K线，5-日K线
}

class DealPriceParam: DealModel {
    var goodsinfos: [KChartParam] = []
    
    class func goodsinfosModelClass() -> AnyClass {
        return KChartParam.classForCoder()
    }
}

class DealParam: BaseModel {
    var id: Int = 0	//用户id
    var token: String = ""	//唯一标识
}
