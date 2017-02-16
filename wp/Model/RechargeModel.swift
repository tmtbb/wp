
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
       var rid: Int64 = 0
     // 用户id
       var id: Int64 = 0
     //充值金额 
       var amount: Double = 0
     // 入金时间  
       var depositTime: String = ""
     // 入金方式 1.微信 2.银行卡	  
       var depositType: Int8 = 0
     //  微信   
       var depositName: String?
    //  1-处理中，2-成功，3-失败
       var status: Int8 = 0
    
}

class  RechargeListModel: BaseModel {
    
    //返回的列表的key
    var depositsinfo : [Model]?
    
    class func depositsinfoModelClass() ->AnyClass {
             return  Model.classForCoder()
    }

}

// 返回充值列表的Model
class Model: BaseModel {
    
    //返回的列表的key
       var rid: Int64 = 0             // 充值订单流水号
       var id: Int64 = 0              // 用户id
       var depositTime : String = ""   // 入金时间
       var depositType: Int8 = 0      // 入金方式 1.微信 2.银行卡
       var depositName: String?       // 微信
       var status: Int8 = 0           // 1-处理中，2-成功，3-失败
       var money : String?            //  金额
       var amount: Double = 0        // jine
    // json 返回数组 来接收对象 调用  RechargeListModel 返回来的model
//    class func depositsinfoModelClass() ->AnyClass {
//        return  RechargeListModel.classForCoder()    }
    
}


