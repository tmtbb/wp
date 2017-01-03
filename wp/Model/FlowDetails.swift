//
//  FlowDetails.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowDetails: BaseModel {
    
    var id: Int64 = 0
    var flowId: Int64 = 0
    var flowType: Int32 = 0
    var flowName: String?
    var inOut: Int32 = 0
    var amount: Double = 0.0
    var balance: Double = 0.0
    var flowTime:Int64 = 0
    var comment: String?
    var flowDetail:Custom?
    
}

class Custom: BaseModel {
    
    //flowType = 1 入金流水时返回
    var depositType: String?
    var depositName: String?
    
    //lowType = 2 出金流水时返回
    var bank: String?
    var cardNo: String?
    var name: String?
    var status: Int8 = 0
    var withdrawAmount: Double = 0.0
    var withdrawCharge: Double = 0.0
    
    //flowType = 3，4 建仓/平仓流水时返回
    var goodsName: String?
    var buySell: Int8 = 0
    var positionAmount: Int32 = 0
    var openPrice: Double = 0.0
    var positionTime: Int64 = 0
    var openCost: Double = 0.0
    var openCharge:Double = 0.0
    var closePrice:Double = 0.0
    var closeTime: uint = 0
    var closeIncome: Double = 0.0
    var closeCharge: Double = 0.0
    var closeType: Int8 = 0
    var closeName:String?
    
}
