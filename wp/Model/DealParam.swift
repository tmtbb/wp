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
    var chartType: Int = 0 //	int32	K线类型	60-1分钟K线，300-5分K线，900-15分K线，1800-30分K线，3600-60分K线，5-日K线
    var startTime: Int64 = 0
    var endTime: Int64 = 0
    var count: Int = Int(AppConst.klineCount)
}

class DealPriceParam: DealModel {
    var goodsinfos: [KChartParam] = []
    
    class func goodsinfosModelClass() -> AnyClass {
        return KChartParam.classForCoder()
    }
}

class DealParam: BaseModel {
    var id: Int = UserModel.share().currentUserId
    var token: String = UserModel.share().token
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

//航班接口信息
class PositionParam: DealParam{
    var gid = 0
}

class BenifityParam: DealParam{
    var tid = 0
    var handle = 0
}

class UndealParam: DealParam {
    var htype = 0
    var start = 0
    var count = 10
}

class DealHistoryDetailParam: DealParam {
    var symbol:String = ""
    var start = 0
    var count = 10
}
