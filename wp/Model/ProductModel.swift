//
//  ProductModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ProductModel: BaseModel {
    var code: String = ""
    var name: String = ""
    var typeCode: String = ""
    var weight: Double = 0.0
    var amountPerLot: Double = 0.0
    var profitPerUnit: Double = 0.0
    var depositFee: Double = 0.0
    var openChargeFee: Double = 0.0
    var CloseChargeFee: Double = 0.0
    var deferredFee: Double = 0.0
    var maxLot: Int = 0
    var minLot: Int = 0
    var Status: Int = 0
    var sort: Int = 0
    var exchangeName: String = ""
    var platformName: String = ""
    
}
