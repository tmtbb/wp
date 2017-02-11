//
//  DealParam.swift
//  wp
//
//  Created by 木柳 on 2017/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class KChartParam: DealParam {
    var symbol: String = ""	//商品类型
    var exchangeName: String = ""	//交易所
    var platformName: String = ""	//平台名称
    var aType: Int = 0 //1.股票 2现货 3期货 4.外汇
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

class BuildDealParam: DealParam {
    var codeId: Int = 0
    var buySell: Int = 0
    var amount: Int = 0
    var prince: Double = 0
    var limit: Int = 0
    var stop: Int = 0
    var isDeferred: Int = 0
}
