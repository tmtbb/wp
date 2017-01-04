//
//  FlowDetails.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowDetails: BaseModel {
    
    dynamic var id: Int64 = 0
    dynamic var flowId: Int64 = 0
    dynamic var flowType: Int32 = 0
    dynamic var flowName: String?
    dynamic var inOut: Int32 = 0
    dynamic var amount: Double = 0.0
    dynamic var balance: Double = 0.0
    dynamic var flowTime:Int64 = 0
    dynamic var comment: String?
    dynamic var flowDetail:Custom?
    
}

class Custom: BaseModel {
    
    //flowType = 1 入金流水时返回
    dynamic var depositType: String?
    dynamic var depositName: String?
    
    //lowType = 2 出金流水时返回
    dynamic var bank: String?
    dynamic var cardNo: String?
    dynamic var name: String?
    dynamic var status: Int8 = 0
    dynamic var withdrawAmount: Double = 0.0
    dynamic var withdrawCharge: Double = 0.0
    
    //flowType = 3，4 建仓/平仓流水时返回
    dynamic var goodsName: String?
    dynamic var buySell: Int8 = 0
    dynamic var positionAmount: Int32 = 0
    dynamic var openPrice: Double = 0.0
    dynamic var positionTime: Int64 = 0
    dynamic var openCost: Double = 0.0
    dynamic var openCharge:Double = 0.0
    dynamic var closePrice:Double = 0.0
    dynamic var closeTime: uint = 0
    dynamic var closeIncome: Double = 0.0
    dynamic var closeCharge: Double = 0.0
    dynamic var closeType: Int8 = 0
    dynamic var closeName:String?
    
}
