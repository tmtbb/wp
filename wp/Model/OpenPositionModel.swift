//
//  OpenPositionModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class PositionModel: BaseModel {
    var positionId:Int = 0      //仓位id
    var id:Int = 0              //用户id
    var code:String = ""            //商品代码
    var typeCode:String = ""        //商品类型代码
    var name:String = ""            //产品名称
    var buySell:Int = 0         //买卖方向	(1-买,2-卖)
    var amount:Int = 0          //持仓手数
    var openPrice:Int = 0       //建仓价格
    var positionTime:Int = 0    //建仓时间
    var openCost:Int = 0        //建仓成本
    var openCharge:Int = 0      //建仓手续费
    var closeTime:Int = 0       //平仓时间	(未平仓时为空)
    var closePrice:Int = 0      //平仓价格	未平仓时为当前价格
    var grossProfit:Int = 0     //交易盈亏	未平仓时为当前浮动盈亏
    var limit:Double = 0           //止盈	不设则为空
    var stop:Double = 0            //止损不设则为空
    var closeType:Int = 0       //平仓类型	1:普通平仓; 2:自动平仓; 3:爆仓平仓; 4:收盘平仓; 5:强制平仓
    var isDeferred:Int = 0      //是否过夜
    var deferred:Int = 0        //累计过夜费
    var token:String = ""           //累计过夜费
}
