//
//  OpenPositionModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift

class PositionModel: Object {
    dynamic var positionId:Int = 0      //仓位id
    dynamic var id:Int = 0              //用户id
    dynamic var code:String = ""        //商品代码
    dynamic var codeId:Int  = 0         //商品代码
    dynamic var typeCode:String = ""    //商品类型代码
    dynamic var name:String = ""        //产品名称
    dynamic var buySell:Int = 0         //买卖方向	(1-买,2-卖)
    dynamic var amount:Int = 0          //持仓手数
    dynamic var openPrice:Double = 0       //建仓价格
    dynamic var positionTime:Int = 0    //建仓时间
    dynamic var openCost:Double = 0        //建仓成本
    dynamic var openCharge:Double = 0      //建仓手续费
    dynamic var closeTime:Int = 0       //平仓时间	(未平仓时为空)
    dynamic var closePrice:Double = 0      //平仓价格	未平仓时为当前价格
    dynamic var grossProfit:Double = 0     //交易盈亏	未平仓时为当前浮动盈亏
    dynamic var limit:Double = 0        //止盈	不设则为空
    dynamic var stop:Double = 0         //止损不设则为空
    dynamic var closeType:Int = 0       //平仓类型	1:普通平仓; 2:自动平仓; 3:爆仓平仓; 4:收盘平仓; 5:强制平仓
    dynamic var isDeferred:Int = 0      //是否过夜
    dynamic var deferred:Int = 0        //累计过夜费
    dynamic var token:String = ""           //累计过夜费
    dynamic var symbol:String?
    dynamic var  result : Bool = true
    dynamic var handle: Int = 0
//    var result :Int  = 0
    dynamic var interval = 0

    override static func primaryKey() -> String{
        return "positionId"
    }
}
//{
//    "positioninfo": [
//    {
//    "amount": 3,
//    "buySell": 1,
//    "closePrice": 0,//收盘价
//    "closeTime": 1486801405,0,
//    "closeType": 6,0,//定时平仓
//    "codeId": 10,
//    "deferred": 0,
//    "grossProfit": -30.6,//盈亏
//    "id": 32,//userid
//    "interval": 60,
//    "isDeferred": false,//过夜费
//    "limit": 0,
//    "name": "上海-法兰克福1分钟",
//    "openCharge": 0,//定时平仓
//    "openCost": 30.6,//建仓费用
//    "openPrice": 7.3005,
//    "positionId": 177400277812916200,//交易ID
//    "positionTime": 1486801345,//建仓时间戳
//    "result": false,//买对
//    "stop": 0,
//    "symbol": "fx_seurcnh"
//    },
//    
//}
