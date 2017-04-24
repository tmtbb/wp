
//
//  RechargeModel.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class  BankModel: BaseModel {
    
    //返回的列表的key
    var cardList : [BankListModel]?
    
    class func  cardListModelClass() ->AnyClass {
        return  BankListModel.classForCoder()
    }
}

//  银行卡返回列表model
class BankListModel: BaseModel {
    
    // 银行卡id
    var bid: Int64 = 0
    // 用户id
    var uid: Int64 = 0
    // 银行名称
    var bank:  String = "bank"
    // 支行名称
    var branchBank: String = "branchBank"
    // 银行卡号
    var cardNo: String = "cardNo"
    //  开户名
    var name: String = "name"
}


class WithdrawResultModel: BaseModel{
    
    //余额
    var balance: Double = 0
    var result: Int = 0
}
