//
//  ProductModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ProductModel: BaseModel {
    /*
     code	string	商品代码
     name	string	商品名称	正为涨 负为跌
     symbol	string	商品类型
     unit	string	商品单位描述
     amountPerLot	double	每手数量(按报价单位计算)	每手商品包含多少个报价单位。例：白银按KG报价，100G吉银的每手数量即为0.1
     profitPerUnit	double	波动盈亏	报价波动1个点时，1手该商品的波动盈亏
     depositFee	double	建仓保证金	1手商品建仓所需保证金，平仓时返还
     openChargeFee	double	建仓手续费	1手商品的建仓手续费
     closeChargeFee	double	平仓手续费	1手商品的平仓手续费（目前系统平仓手续费为0）
     depositFee	double	过夜费	1手商品递延1晚收取的费用
     maxLot	int32	最大持仓手数
     minLot	int32	最小下单手数(默认为1)
     status	int32	商品状态(1-正常,2-暂停交易)	
     sort	int32	排序
     */
    var code: String = ""
    var name: String = ""
    var typeCode: String = ""
    var symbol: String = ""
    var goodType: String = ""
    var weight: Double = 0.0
    var amountPerLot: Double = 0.0
    var profitPerUnit: Double = 0.0
    var profit: Double = 0.0
    var depositFee: Double = 0.0
    var deposit: Double = 0.0
    var openChargeFee: Double = 0.0
    var open: Double = 0.0
    var closeChargeFee: Double = 0.0
    var close: Double = 0.0
    var deferredFee: Double = 0.0
    var deferred: Double = 0.0
    var maxLot: Int = 0
    var minLot: Int = 0
    var Status: Int = 0
    var sort: Int = 0
    var exchangeName: String = ""
    var platformName: String = ""

}
