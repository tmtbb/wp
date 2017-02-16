//
//  WithdrawModel.swift
//  wp
//
//  Created by macbook air on 17/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
// 提现moedel
class WithdrawModel: BaseModel {
    
    var wid: Int64 = 0           // 提现订单流水号
    var uid: Int64 = 0           // 用户id
    var amount: Double = 0       // 提现金额
    var charge: Int64 = 0        // 提现手续费
    var withdrawTime : String = ""  // 提现时间
    var handleTime: Int64 = 0    //提现时间
    var bank: String!            // 银行名称
    var branchBank: String!      //支行名称
    var province: String!        // 	省
    var city: String!            // 	城市
    var cardNo: String!          // 	银行卡号
    var name: String!            // 姓名
    var comment: String!         //	备注
    var status: Int8 = 0        // 状态	1-处理中，2-成功，3-失败
    var expectTime: String!        // 	省
    
    
}
// 提现列表的listmodel
class WithdrawListModel: BaseModel {
    
    var withdrawList : [WithdrawModel]!
    
    class func withdrawListModelClass() ->AnyClass {
        return  WithdrawModel.classForCoder()
    }
    
    
}
// 银行卡提现moedel
class WithdrawBankCashModel: BaseModel {
    
    
    var wid: Int64 = 0               // 提现订单流水号
    var id: Int64 = 0                // 用户id
    var amount: Double = 0           // 提现金额
    var charge: Int64 = 0            // 提现手续费
    var withdrawTime: Int64 = 0      // 提现时间
    var handleTime: Int64 = 0        //提现时间
    var bank: String!                // 银行名称
    var branchBank: String!          //支行名称
    var province: String!            // 	省
    var city: String!                // 	城市
    var cardNo: String!              // 	银行卡号
    var name: String!                // 姓名
    var comment: String!             //	备注
    var status: Int8 = 0             // 状态	1-处理中，2-成功，3-失败
    
}

