//
//  DealModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealModel: BaseModel {
    private static var model: DealModel = DealModel()
    class func share() -> DealModel{
        return model
    }
    dynamic var selectDealModel: PositionModel?
    var dealUp: Bool = true
    
    
}
