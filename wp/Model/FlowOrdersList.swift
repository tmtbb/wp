//
//  FlowOrdersList.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowOrdersList: BaseModel {
    var flowId: Int64 = 0
    var flowType: Int32 = 0
    var flowName: String?
    var inOut: Int32 = 0
    var amount: Double = 0.0
    var balance: Double = 0.0
    var flowTime: Int64 = 0
    var comment: String?
}
