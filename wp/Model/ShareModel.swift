//
//  ShareModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/27.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class ShareModel: BaseModel {
    private static var model: ShareModel = ShareModel()
    class func share() -> ShareModel{
        return model
    }
    //设置选中的类型
    var selectType : String = " "
    //选中的月份
    dynamic var selectMonth : String = " "
    //用户的金额
    dynamic var userMoney : Double = 0
    //用来传详情的model
    var detailModel  =  WithdrawModel()
    // 选中的银行
    dynamic var selectBank  = BankListModel()
    // 用来判读是充值详情还是体现详情
    var comeFromRechage :  Bool = true
    
    //定义全局的字典 用来传值
    var shareData = Dictionary<String, String>()
    
    
}



