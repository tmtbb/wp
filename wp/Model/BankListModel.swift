//
//  BankListModel.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BankListModel: BaseModel {
    
    //银行卡键名
    var cardlist : [BankModel]!
    
    class func cardlistModelClass() ->AnyClass {
        return  BankModel.classForCoder()
    }
    
}

class BankModel: BaseModel {
    
    // 银行卡id
    //    var cardId: Int64 = 0
    // 用户id
//    var uid: Int64 = 0
    //	银行名称
    var bank: String?
    // 支行名称
    var branchBank: String = " "
    //  银行卡号
    var cardNo: String = " "
    //  姓名
    var name: String  = " "
    //  姓名
    var bankId: String  = " "

}
