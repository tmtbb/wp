//
//  CreditModel.swift
//  wp
//
//  Created by macbook air on 17/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class CreditModel: BaseModel {
    
    dynamic var rid: Int64 = 0                  //充值订单流水号
    dynamic var id: Int64 = 0                   //用户id
    dynamic var amount: Double = 0.0            //充值金额
    dynamic var depositTime: Int64 = 0          //入金时间
    dynamic var depositType: Int8 = 0           //入金方式:1.微信  2.银行卡
    dynamic var depositName: String?            //微信
    dynamic var status: Int8 = 0                //1-处理中, 2-成功, 3-失败
    
}
