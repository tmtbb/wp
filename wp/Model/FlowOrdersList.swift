//
//  FlowOrdersList.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowOrdersList: BaseModel {
    dynamic var flowId: Int64 = 0          //订单流水号
    dynamic var flowType: Int32 = 0        //订单类型
    dynamic var flowName: String?          //订单类型名称
    dynamic var inOut: Int32 = 0           //收支类型 1-收入, 2-支出
    dynamic var amount: Double = 0.0       //金额
    dynamic var balance: Double = 0.0      //账户余额
    dynamic var flowTime: Int64 = 0        //订单时间
    dynamic var comment: String?           //备注
}
