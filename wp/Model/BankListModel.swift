
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
    var cardlist : [BankListModel]?
    
    class func  cardlistModelClass() ->AnyClass {
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
    // 入金时间
    var branchBank: String = "branchBank"
    // 入金方式 1.微信 2.银行卡
    var cardNo: String = "cardNo"
    //  微信
    var name: String = "name"

    
}



