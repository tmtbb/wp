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
    
    /*姓名*/
    var name  = ""
    
    /*类别*/
    var type = ""
    
    /*时间*/
    var time  = ""
    
    /*收益*/
    var benifity  = ""
    
    /*头像*/
    var userHeaderImg = ""
    
    /*姓名*/
    var iconImg  = ""
    
    /*状态*/
    var status = ""
    
}

