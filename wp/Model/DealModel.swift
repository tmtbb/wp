//
//  DealModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealModel: BaseModel {
    
    enum SeletedType: Int {
        case btnTapped = 0
        case cellTapped = 1
    }
    
    private static var model: DealModel = DealModel()
    class func share() -> DealModel{
        return model
    }
    var dealDic: [String: AnyObject]?
    
    //点击类型
    var type:SeletedType = .btnTapped
    //所选择的持仓模型
    dynamic var selectDealModel: PositionModel?
    //买涨买跌
    var dealUp: Bool = true
    //是否是持仓详情
    var isDealDetail: Bool = false
    
    
}
