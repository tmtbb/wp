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
    
    var selectType : String = " "
    
    dynamic var selectMonth : String = " "
    
    var detailModel  =  WithdrawModel()
    
   
    
    dynamic var selectBank  = BankListModel()
    
    //定义全局的字典 用来传值
    var shareData = Dictionary<String, String>()
    
    
}



