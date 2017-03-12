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
    
    enum ChartType: Int {
        case timeLine = 1
    }
    
    var isFirstGetPrice = false
    var difftime = 0
    
    private static var model: DealModel = DealModel()
    class func share() -> DealModel{
        return model
    }
    //所有商品列表
    dynamic var allProduct: [ProductModel] = []
    //商品分类列表
    dynamic var productKinds: [ProductModel] = []
    //所选择的商品大类
    dynamic var selectProduct: ProductModel?
    dynamic var selectProductIndex: Int = 0
    //所选择的商品小类
    var buyProduct: ProductModel?
    //买涨买跌
    var dealUp: Bool = true
    var buyModel: PositionModel = PositionModel()
    //是否是持仓详情
    var isDealDetail: Bool = false
    //数据库是否已经有数据
    var haveDealModel: Bool = false
    //当前k线类型
    var klineTye: KLineModel.KLineType = .miu
    //当前选择K线索引
    var selectIndex: NSInteger!{
        didSet{
            switch selectIndex {
            case 0:
                klineTye = .miu
                break
            case 1:
                klineTye = .miu5
                break
            case 2:
                klineTye = .miu15
                break
            case 3:
                klineTye = .miu30
                break
            case 4:
                klineTye = .miu60
                break
            default:
                klineTye = .miu
                break
            }
        }
    }
    
    class func checkIfSuspended() -> Bool {
        
        let realm = try! Realm()
        
        let model = realm.objects(KChartModel.self).sorted(byProperty: "priceTime", ascending: false).first
        
        guard model != nil else {
            return true
        }
        return model!.systemTime - model!.priceTime > 60
        
        
    }
    
    // 缓存建仓数据
    class func cachePosition(position: PositionModel){
        let realm = try! Realm()
        try! realm.write {
            realm.add(position, update: true)
        }
        DealModel.refreshDifftime()
    }
    
    class func getAllPositionModel() -> Results<PositionModel>{
        let realm = try! Realm()
        return realm.objects(PositionModel.self).filter("closeTime > \(Int(NSDate().timeIntervalSince1970) + DealModel.share().difftime)").sorted(byProperty: "positionTime", ascending: false)
    }
    class func getHistoryPositionModel() -> Results<PositionModel>{
        let realm = try! Realm()
        return realm.objects(PositionModel.self).filter("grossProfit > 0").sorted(byProperty: "positionTime", ascending: false)
    }
    class func cachePositionWithArray(positionArray:Array<PositionModel>) {
        let realm = try! Realm()
        
            try! realm.write {
                for positionModel in positionArray {
                    realm.add(positionModel, update: true)
                }
        }
    }
    
    class func getAHistoryPositionModel() -> Results<PositionModel>{
        let realm = try! Realm()
        return realm.objects(PositionModel.self).filter("closeTime < \(Int(NSDate().timeIntervalSince1970))").sorted(byProperty: "positionTime", ascending: false)
    }
    
    class func refreshDifftime() {
        let model = getAllPositionModel().first
        guard model != nil else {return}
        DealModel.share().difftime = model!.closeTime - model!.interval - Int(NSDate().timeIntervalSince1970)
    }
}
