//
//  KLineModel.swift
//  wp
//
//  Created by 木柳 on 2017/1/16.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
class KLineModel: NSObject {
    private static var minTime: Int = Int(Date.startTimestemp())
    private static var maxTime: Int = 0
    static var min15Time: Int = 0
    static var min60Time: Int = 0
    static var max15Time: Int = 0
    static var max60Time: Int = 0

    
    //缓存分时数据
    class func cacheTimelineModels(models: [KChartModel], goodType: String) {
        let _ = autoreleasepool(invoking: {
            for (_, model) in models.enumerated() {
                let realm = try! Realm()
                model.goodType = goodType
                //缓存分时线
                try! realm.write {
                    realm.add(model, update: true)
                }
            }
        })
    }
    
    //以某个时间间隔为标准，查询对应的数据
    class func queryModels(type: KLineView.KType, goodType: String, complete: @escaping CompleteBlock){
        let margin = type.rawValue * 60
        var min = minTime
        switch type {
        case .miu15:
            min = max15Time > min ? max15Time : min
            break
        case .miu60:
            min = max60Time > min ? max60Time : min
            break
        default:
            break
        }
        
        var max = min + margin
        let current = Int(Date.nowTimestemp())
        while max < current {
            let model = queryModel(goodType: goodType, fromTime: min, toTime: max)
            if model == nil {
                switch type {
                case .miu15:
                    max15Time = max
                    break
                case .miu60:
                    max60Time = max
                    break
                default:
                    break
                }
                break
            }
            complete(model as AnyObject)
            min = max
            max = min + margin
        }
    }
    
    //查询某个时间段的K线数据并计算出该时间段的K线模型
    class func queryModel(goodType: String, fromTime: Int, toTime: Int) -> KChartModel? {
        var resultModel: KChartModel?
        let realm = try! Realm()
        let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
        let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime").filter(queryStr).filter("priceTime > \(fromTime)").filter("priceTime < \(toTime)")
        
        for (index, model) in result.enumerated() {
            if index == 0 {
                resultModel = KChartModel()
                resultModel!.goodType = model.goodType
                resultModel!.exchangeName = model.exchangeName
                resultModel!.platformName = model.platformName
                resultModel!.currentPrice = model.currentPrice
                resultModel!.change = model.change
                resultModel!.openingTodayPrice = model.openingTodayPrice
                resultModel!.closedYesterdayPrice = model.closedYesterdayPrice
                resultModel!.highPrice = resultModel!.currentPrice
                resultModel!.lowPrice = resultModel!.currentPrice
                resultModel!.openPrice = resultModel!.currentPrice
            }else{
                //收盘价
                if index == result.count - 1 {
                    resultModel?.closePrice = model.currentPrice
                }
                //最高价
                if resultModel!.highPrice < model.currentPrice {
                    resultModel!.highPrice = model.currentPrice
                }
                //最低价
                if resultModel!.lowPrice > model.currentPrice {
                    resultModel!.lowPrice = model.currentPrice
                }
            }
        }
        return resultModel
    }
    
    //读取分时数据
    class func queryTimelineModels(fromTime: Int, toTime: Int, goodType: String, complete: @escaping CompleteBlock){
        let _ = autoreleasepool(invoking: {
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
            let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime").filter(queryStr).filter("priceTime > \(fromTime)").filter("priceTime < \(toTime)")
            for model in result {
                models.append(model)
            }
            complete(models as AnyObject?)
            print("===========================\(Thread.current)")
        })
        
    }
    //读取15k数据
    class func query15kModels(goodType: String, complete: @escaping CompleteBlock) {
    
            var models: [KChartModelQuarter] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
            let result = realm.objects(KChartModelQuarter.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                let _ = autoreleasepool(invoking: {
                    models.append(model)
                })
            }
            complete(models as AnyObject?)
        
        
    }
    //读取60k数据
    class func queryHourKModels(goodType: String, complete: @escaping CompleteBlock)  {
            var models: [KChartModelHour] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
            let result = realm.objects(KChartModelHour.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                let _ = autoreleasepool(invoking: {
                    models.append(model)
                })
            }
            complete(models as AnyObject?)
        
    }
    //读取日k数据
    class func queryDayKModels(goodType: String, complete: @escaping CompleteBlock)  {
            var models: [KChartModelDay] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
            let result = realm.objects(KChartModelDay.self).filter(queryStr)
            for (_, model) in result.enumerated() {
                let _ = autoreleasepool(invoking: {
                    models.append(model)
                })
            }
            complete(models as AnyObject?)
    }
}
