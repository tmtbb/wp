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
    
    //缓存分时数据
    class func cacheTimelineModels(models: [KChartModel], goodType: String) {
        DispatchQueue.global().async{
            for (_, model) in models.enumerated() {
                let _ = autoreleasepool(invoking: {
                    let realm = try! Realm()
                    model.goodType = goodType
                    //缓存分时线
                    try! realm.write {
                        realm.add(model, update: true)
                    }
                })
            }
        }
    }
    
    
    //缓存K线数据
    class func cacheKTimelimeModels() {
       
        DispatchQueue.global().async {
            let realm = try! Realm()
            let result: Results<KChartModel>?
            if maxTime == 0 {
                result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime")
            }else{
                let queryStr = NSPredicate.init(format: "priceTime > %d",maxTime)
                result = realm.objects(KChartModel.self).filter(queryStr).sorted(byProperty: "priceTime")
            }
            var modelQuarter = KChartModelQuarter()
            var modelHour = KChartModelHour()
            var modelDay = KChartModelHour()
            for (index, model) in (result?.enumerated())! {
                let _ = autoreleasepool(invoking: {
                    // 最大时间值
                    if model.priceTime > maxTime{
                        maxTime = model.priceTime
                    }
                    //缓存15k数据
                    let her15k = index % 15
                    if her15k == 0 {
                        modelQuarter = KChartModelQuarter()
                        modelQuarter.priceTime = model.priceTime
                        modelQuarter.goodType = model.goodType
                        modelQuarter.openPrice = model.currentPrice
                        modelQuarter.lowPrice = model.currentPrice
                        modelQuarter.highPrice = model.currentPrice
                    }else{
                        if modelQuarter.highPrice < model.currentPrice  {
                            modelQuarter.highPrice =  model.currentPrice
                        }
                        if modelQuarter.lowPrice > model.currentPrice {
                            modelQuarter.lowPrice = model.currentPrice
                        }
                        
                        if her15k == 14{
                            modelQuarter.closePrice = model.currentPrice
                            try! realm.write {
                                realm.add(modelQuarter, update: true)
                            }
                        }
                    }
                    
                    //缓存60k数据
                    
                    let her60k = index % 60
                    if her60k == 0 {
                        modelHour = KChartModelHour()
                        modelHour.priceTime = model.priceTime
                        modelHour.goodType = model.goodType
                        modelHour.openPrice = model.currentPrice
                        modelHour.lowPrice = model.currentPrice
                        modelHour.closePrice = model.currentPrice
                        modelHour.highPrice = model.currentPrice
                    }else{
                        if modelHour.highPrice < model.currentPrice  {
                            modelHour.highPrice = model.currentPrice
                        }
                        if modelHour.lowPrice > model.currentPrice {
                            modelHour.lowPrice =  model.currentPrice
                        }
                        if her60k == 59 {
                            modelHour.closePrice = model.currentPrice
                            try! realm.write {
                                realm.add(modelHour, update: true)
                            }
                        }
                    }
                    
                    
                    //缓存日k数据
                    let herDayk = index % (60*24)
                    if herDayk == 0 {
                        modelDay = KChartModelHour()
                        modelDay.goodType = model.goodType
                        modelDay.priceTime = model.priceTime
                        modelDay.openPrice = model.currentPrice
                        modelDay.lowPrice = model.currentPrice
                        modelDay.closePrice = model.currentPrice
                        modelDay.highPrice = model.currentPrice
                    }else{
                        if modelDay.highPrice < model.currentPrice  {
                            modelDay.highPrice = model.currentPrice
                        }
                        if modelDay.lowPrice > model.currentPrice {
                            modelDay.lowPrice =  model.currentPrice
                        }
                        if herDayk == 60*24-1 {
                            modelDay.closePrice = model.currentPrice
                            try! realm.write {
                                realm.add(modelHour, update: true)
                            }
                        }
                    }
                    
                })
            }
            
            let time = 60*15
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TimeInterval(time)) {
                cacheKTimelimeModels()
            }
        }
        
    }
    
    
    //以某个时间间隔为标准，查询对应的数据
    class func queryModels(margin: Int, goodType: String, complete: @escaping CompleteBlock){
        var min = minTime
        var max = min + margin
        let current = Int(Date.nowTimestemp())
        while max < current {
            let model = queryModel(goodType: goodType, fromTime: min, toTime: max)
            if model == nil {
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
            if resultModel == nil {
                resultModel = model
                resultModel!.highPrice = resultModel!.currentPrice
                resultModel!.lowPrice = resultModel!.currentPrice
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
    class func queryTimelineModels(page: Int, goodType: String, complete: @escaping CompleteBlock){
        DispatchQueue.global().async {
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
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
    class func query15kModels(goodType: String, complete: @escaping CompleteBlock) {
        DispatchQueue.global().async {
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
        
    }
    //读取60k数据
    class func queryHourKModels(goodType: String, complete: @escaping CompleteBlock)  {
        DispatchQueue.global().async {
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
    }
    //读取日k数据
    class func queryDayKModels(goodType: String, complete: @escaping CompleteBlock)  {
        DispatchQueue.global().async {
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
}
