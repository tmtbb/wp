//
//  FlowOrdersList.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowOrdersList: BaseModel {
    dynamic var flowId: Int64 = 0
    dynamic var flowType: Int32 = 0
    dynamic var flowName: String?
    dynamic var inOut: Int32 = 0
    dynamic var amount: Double = 0.0
    dynamic var balance: Double = 0.0
    dynamic var flowTime: Int64 = 0
    dynamic var comment: String?
}
