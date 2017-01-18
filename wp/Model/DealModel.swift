//
//  DealModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
class DealModel: BaseModel {
    
    enum SeletedType: Int {
        case btnTapped = 0
        case cellTapped = 1
    }
    
    enum ChartType: Int {
        case timeLine = 1
    }
    
    private static var model: DealModel = DealModel()
    class func share() -> DealModel{
        return model
    }
    //所有商品列表
    dynamic var allProduct: [ProductModel] = []
    //点击类型
    var type:SeletedType = .btnTapped
    //所选择的持仓模型
    dynamic var selectDealModel: PositionModel?
    //所选择的商品
    var selectProduct: ProductModel?
    //买涨买跌
    var dealUp: Bool = true
    var buyModel: PositionModel = PositionModel()
    //是否是持仓详情
    var isDealDetail: Bool = false
    //数据库是否已经有数据
    var haveDealModel: Bool = false
}
