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
     var name  : String?
    
    /*类别*/
      var type : String?
    
    /*时间*/
     var time  : String?
    /*收益*/
     var benifity : String?
    
    /*头像*/
     var userHeaderImg : String?
    
    /*姓名*/
     var iconImg  : String?
    
    /*状态*/
      var status : String?
    
}

