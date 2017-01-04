//
//  WithdrawModel.swift
//  wp
//
//  Created by macbook air on 17/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class WithdrawModel: BaseModel {
    
    dynamic var wid: Int64 = 0
    dynamic var id: Int64 = 0
    dynamic var amount: Double = 0
    dynamic var charge: Int64 = 0
    dynamic var withdrawTime: Int64 = 0
    dynamic var handleTime: Int64 = 0
    dynamic var bank: String?
    dynamic var branchBank: String?
    dynamic var province: String?
    dynamic var city: String?
    dynamic var cardNo: String?
    dynamic var name: String?
    dynamic var comment: String?
    dynamic var status: Int8 = 0
}
