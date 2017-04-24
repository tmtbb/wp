//
//  HomeParam.swift
//  wp
//
//  Created by mu on 2017/4/22.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation


class RechargeParam: BaseParam{
    var merchantNo = ""
    var currency = "CNY"
    var amount: Double = 0
    var content = ""
    var payType = "H5"
}

class WithDrawalParam: BaseParam{
    var merchantNo = ""
    var amount: Double = 0
    var content = ""
    var receiverBankName = ""
    var receiverBranchBankName = ""
    var receiverBranchBankCode = ""
    var receiverCardNo = ""
    var receiverAccountName = ""
}
