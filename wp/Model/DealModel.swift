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
    private var modelQuarter: KChartModelQuarter = KChartModelQuarter()
    private var modelHour: KChartModelHour = KChartModelHour()
    private var modelDay: KChartModelDay = KChartModelDay()
    private var minTime: Int = 0
    private var maxTime: Int = 0
    
    class func share() -> DealModel{
        return model
    }
   
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
    func cacheTimelineModels(models: [KChartModel], goodType: String) {
        DispatchQueue.global().async {
            for (_, model) in models.enumerated() {
                let realm = try! Realm()
                model.goodType = goodType
                //缓存分时线
                try! realm.write {
                    realm.add(model, update: true)
                }
                let _ = autoreleasepool(invoking: {
                    model
                })
            }
        }
    }
    //缓存K线数据
    func cacheKTimelimeModels() {
        DispatchQueue.global().async { [weak self] in
            let realm = try! Realm()
            let result: Results<KChartModel>?
            if self?.maxTime == 0 {
                result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime")
            }else{
                let queryStr = NSPredicate.init(format: "priceTime > %d",(self?.maxTime)!)
                result = realm.objects(KChartModel.self).filter(queryStr)
            }
            for (index, model) in (result?.enumerated())! {
                self?.modelQuarter.priceTime = model.priceTime
                self?.modelQuarter.goodType = model.goodType
                if (self?.modelQuarter.highPrice)! < model.highPrice  {
                    self?.modelQuarter.highPrice = model.highPrice
                }
                if (self?.modelQuarter.lowPrice)! > model.lowPrice {
                    self?.modelQuarter.lowPrice =  model.lowPrice
                }
                //缓存15k数据
                let her15k = index % 15
                if her15k == 14 {
                    self?.modelQuarter.closedYesterdayPrice = model.closedYesterdayPrice
                    try! realm.write {
                        realm.add((self?.modelQuarter)!, update: true)
                    }
                    self?.modelQuarter = KChartModelQuarter()
                    
                }else{
                    if her15k == 0 {
                        self?.modelQuarter.openingTodayPrice = model.openingTodayPrice
                        self?.modelQuarter.lowPrice = model.lowPrice
                    }
                }
                //缓存60k数据
                self?.modelHour.priceTime = model.priceTime
                self?.modelHour.goodType = model.goodType
                if (self?.modelHour.highPrice)! < model.highPrice  {
                    self?.modelHour.highPrice = model.highPrice
                }
                if (self?.modelHour.lowPrice)! > model.lowPrice {
                    self?.modelHour.lowPrice =  model.lowPrice
                }
                let her60k = index % 60
                if her60k == 59 {
                    self?.modelHour.closedYesterdayPrice = model.closedYesterdayPrice
                    try! realm.write {
                        realm.add((self?.modelHour)!, update: true)
                    }
                    self?.modelHour = KChartModelHour()
                }else{
                    if her60k == 0 {
                        self?.modelHour.openingTodayPrice = model.openingTodayPrice
                        self?.modelHour.lowPrice = model.lowPrice
                    }
                }
                //缓存日k数据
                self?.modelDay.priceTime = model.priceTime
                self?.modelDay.goodType = model.goodType
                if (self?.modelDay.highPrice)! < model.highPrice  {
                    self?.modelDay.highPrice = model.highPrice
                }
                if (self?.modelDay.lowPrice)! > model.lowPrice {
                    self?.modelDay.lowPrice =  model.lowPrice
                }
                let herDayk = index % (60*24)
                if herDayk == 60*24-1 {
                    self?.modelDay.closedYesterdayPrice = model.closedYesterdayPrice
                    try! realm.write {
                        realm.add((self?.modelHour)!, update: true)
                    }
                    self?.modelHour = KChartModelHour()
                }else{
                    if herDayk == 0 {
                        self?.modelDay.openingTodayPrice = model.openingTodayPrice
                        self?.modelDay.lowPrice = model.lowPrice
                    }
                }
                
                let _ = autoreleasepool(invoking: {
                    model
                })
            }
            
            let time = result?.count == 0 ? 10:60*15
            let _ = self?.delay(TimeInterval(time)) { [weak self] in
                self?.cacheKTimelimeModels()
            }
        }
       
    }
    
    //读取分时数据
    func queryTimelineModels(page: Int, complete: @escaping CompleteBlock){
        DispatchQueue.global().async { [weak self] in
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",(self?.selectProduct?.goodType)!)
            let result = realm.objects(KChartModel.self).filter(queryStr)
            for (index, model) in result.enumerated() {
                if index < 60*24*page {
                    models.append(model)
                }else{
                    break
                }
            }
            complete(models as AnyObject?)
        }
    }
    //读取15k数据
    func query15kModels(complete: @escaping CompleteBlock) {
        DispatchQueue.global().async { [weak self] in
            var models: [KChartModelQuarter] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",(self?.selectProduct?.goodType)!)
            let result = realm.objects(KChartModelQuarter.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                models.append(model)
                let _ = autoreleasepool(invoking: {
                    model
                })
            }
            complete(models as AnyObject?)
        }
        
        
    }
    //读取60k数据
    func queryHourKModels(complete: @escaping CompleteBlock)  {
        DispatchQueue.global().async { [weak self] in
            var models: [KChartModelHour] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",(self?.selectProduct?.goodType)!)
            let result = realm.objects(KChartModelHour.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                models.append(model)
                let _ = autoreleasepool(invoking: {
                    model
                })
            }
            complete(models as AnyObject?)
        }
    }
    //读取日k数据
    func queryDayKModels(complete: @escaping CompleteBlock)  {
        DispatchQueue.global().async { [weak self] in
            var models: [KChartModelDay] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",(self?.selectProduct?.goodType)!)
            let result = realm.objects(KChartModelDay.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                models.append(model)
                let _ = autoreleasepool(invoking: {
                    model
                })
            }
            complete(models as AnyObject?)
        }
        
    }
}
