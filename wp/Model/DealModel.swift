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
    var dealDic: [String: AnyObject]?
    
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
    
    //缓存分时数据
    func cacheTimelineModels(models: [KChartModel]) {
        for model in models {
            model.chartType = ChartType.timeLine.rawValue
            let realm = try! Realm()
            try! realm.write {
                realm.add(model, update: true)
            }
        }
    }
    //分页读取分时数据
    func queryTimelineModels(page: Int) -> [KChartModel] {
        var models: [KChartModel] = []
        let realm = try! Realm()
        let queryStr = NSPredicate.init(format: "chartType = %d",ChartType.timeLine.rawValue)
        let result = realm.objects(KChartModel.self).filter(queryStr)
        for (index, model) in result.enumerated() {
            if index < 60*24*page {
                models.append(model)
            }else{
                break
            }
        }
        return models
    }
    
}
