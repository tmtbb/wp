
//
//  RechargeModel.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//  充值详情Model
class RechargeDetailModel: BaseModel {
    
    
     // 充值订单流水号  
    dynamic var rid: Int64 = 0
     // 用户id
    dynamic var id: Int64 = 0
     //充值金额 
    dynamic var amount: Double = 0
     // 入金时间  
    dynamic var depositTime: Int64 = 0
     // 入金方式 1.微信 2.银行卡	  
    dynamic var depositType: Int8 = 0
     //  微信   
    dynamic var depositName: String?
    //  1-处理中，2-成功，3-失败
    dynamic var status: Int8 = 0
    
}

//{
//    "depositsinfo": [
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    },
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    },
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    }
//    ]
//}
// 返回充值列表的Model
class RechargeListModel: BaseModel {
    
    //返回的列表的key
    var depositsinfo : [RechargeListModel]?
     // 充值订单流水号
    dynamic var rid: Int64 = 0
     // 用户id
    dynamic var id: Int64 = 0
     // 入金时间  
    dynamic var depositTime : Int64 = 0
     // 入金方式 1.微信 2.银行卡  
    dynamic var depositType: Int8 = 0
     // 微信  
    dynamic var depositName: String?
     // 1-处理中，2-成功，3-失败	
    
    dynamic var status: Int8 = 0
   
    class func depositsinfoModelClass() ->AnyClass {
        return  [RechargeListModel].self as!  AnyClass
    }
    
}

//{
//    "depositsinfo": [
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    },
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    },
//    {
//    "rid": 10000002,
//    "id": 10001,
//    "amount": 100.1,
//    "depositTime": 1483422506,
//    "depositType": 1,
//    "depositName": "微信",
//    "status": 1
//    }
//    ]
//}
//



//

