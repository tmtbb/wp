//
//  FlowDetails.swift
//  wp
//
//  Created by macbook air on 17/1/3.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FlowDetails: BaseModel {
    
    dynamic var basic: Basic?
    
    dynamic var flowdetail: Custom?                 //根据flow Type不同而返回不同
    
}
class Basic: BaseModel {
    dynamic var id: Int64 = 0                       //用户id
    dynamic var flowId: Int64 = 0                   //订单流水号
    dynamic var flowType: Int32 = 0                 //订单类型
    dynamic var flowName: String?                   //订单类型名称
    dynamic var inOut: Int32 = 0                    //收支类型
    dynamic var amount: Double = 0.0                //金额
    dynamic var balance: Double = 0.0               //账户余额
    dynamic var flowTime:Int64 = 0                  //订单时间
    dynamic var comment: String?                    //备注
}

class Custom: BaseModel {
    
    //flowType = 1 入金流水时返回
    dynamic var depositType: String?                //入金方式
    dynamic var depositName: String?                //入金方式名
    
    //flowType = 2 出金流水时返回
    dynamic var bank: String?                       //银行
    dynamic var cardNo: String?                     //银行卡号
    dynamic var name: String?                       //姓名
    dynamic var status: Int8 = 0                    //出金状态
    dynamic var withdrawAmount: Double = 0.0        //出金金额
    dynamic var withdrawCharge: Double = 0.0        //出金手续费
    
    //flowType = 3，4 建仓/平仓流水时返回
    dynamic var goodsName: String?                  //商品名称
    dynamic var buySell: Int8 = 0                   //建仓方向
    dynamic var positionAmount: Int32 = 0           //建仓手数
    dynamic var openPrice: Double = 0.0             //建仓价格
    dynamic var positionTime: Int64 = 0             //建仓时间
    dynamic var openCost: Double = 0.0              //建仓成本
    dynamic var openCharge:Double = 0.0             //建仓手续费
    dynamic var closePrice:Double = 0.0             //平仓价格
    dynamic var closeTime: uint = 0                 //平仓时间
    dynamic var closeIncome: Double = 0.0           //平仓收入
    dynamic var closeCharge: Double = 0.0           //平仓手续费
    dynamic var closeType: Int8 = 0                 //平仓类型
    dynamic var closeName:String?                   //平仓名称
    
}
