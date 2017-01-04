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
    
    func Transfrom(_ requestData: NSDictionary) -> DealModel {
        
        
        return DealModel.share();
    }
    
}
