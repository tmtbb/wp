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
    
    // 提现订单流水号  
    dynamic var wid: Int64 = 0
    // 用户id	  
    dynamic var id: Int64 = 0
    // 提现金额   
    dynamic var amount: Double = 0
    // 提现手续费		  
    dynamic var charge: Int64 = 0
    // 提现时间	  
    dynamic var withdrawTime: Int64 = 0
    //提现时间	  
    dynamic var handleTime: Int64 = 0
    // 银行名称	  
    dynamic var bank: String?
    //支行名称
    dynamic var branchBank: String?
    // 	省	  
    dynamic var province: String?
    // 	城市	  
    dynamic var city: String?
    // 	银行卡号	  
    dynamic var cardNo: String?
    // 姓名	  
    dynamic var name: String?
    //	备注	  
    dynamic var comment: String?
    // 状态	1-处理中，2-成功，3-失败
    dynamic var status: Int8 = 0

}
// 提现列表的listmodel
class WithdrawListModel: BaseModel {
    
    var listItem : [WithdrawModel]?
    
}
// 银行卡提现moedel
class WithdrawBankCashModel: BaseModel {
    
    // 提现订单流水号
    dynamic var wid: Int64 = 0
    // 用户id
    dynamic var id: Int64 = 0
    // 提现金额
    dynamic var amount: Double = 0
    // 提现手续费
    dynamic var charge: Int64 = 0
    // 提现时间
    dynamic var withdrawTime: Int64 = 0
    //提现时间
    dynamic var handleTime: Int64 = 0
    // 银行名称
    dynamic var bank: String?
    //支行名称
    dynamic var branchBank: String?
    // 	省
    dynamic var province: String?
    // 	城市
    dynamic var city: String?
    // 	银行卡号
    dynamic var cardNo: String?
    // 姓名
    dynamic var name: String?
    //	备注
    dynamic var comment: String?
    // 状态	1-处理中，2-成功，3-失败
    dynamic var status: Int8 = 0
    
}

