//
//  WithdrawModel.swift
//  wp
//
//  Created by macbook air on 17/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class WithdrawModel: BaseModel {
    
    dynamic var wid: Int64 = 0              //提现订单流水号
    dynamic var id: Int64 = 0               //用户id
    dynamic var amount: Double = 0          //提现金额
    dynamic var charge: Int64 = 0           //提现手续费
    dynamic var withdrawTime: Int64 = 0     //提现时间
    dynamic var handleTime: Int64 = 0       //处理时间
    dynamic var bank: String?               //银行名称
    dynamic var branchBank: String?         //支行名称
    dynamic var province: String?           //省
    dynamic var city: String?               //城市
    dynamic var cardNo: String?             //银行卡号
    dynamic var name: String?               //姓名
    dynamic var comment: String?            //备注
    dynamic var status: Int8 = 0            //状态 1-处理中, 2-成功, 3-失败
}
