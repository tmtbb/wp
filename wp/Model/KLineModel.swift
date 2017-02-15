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
    private static var queue = DispatchQueue.init(label: "timeline")
    
    enum KLineType: Int {
        case miu = 60   //1分钟
        case miu5 = 300  //5分钟
        case miu15 = 900 //15分钟
        case miu30 = 1800 //30分钟
        case miu60 = 3600 //60分钟
        case day = 5   //日K线
    }
    
    //缓存分时数据
    class func cacheTimelineModels(models: [KChartModel]) {
        let _ = autoreleasepool(invoking: {
            if models.count == 0{
                return
            }
            queue.async(execute: {
                let realm = try! Realm()
                let firstModel = models.first
                let queryStr = NSPredicate.init(format: "symbol = %@",firstModel!.symbol)
                let result = realm.objects(KChartModel.self).filter(queryStr)
                let goodMaxTime: Int = result.max(ofProperty: "priceTime") ?? 0
                let goodMinTime: Int = result.min(ofProperty: "priceTime") ?? 0
                for (_, model) in models.enumerated() {
                    if model.priceTime > goodMaxTime || model.priceTime < goodMinTime{
                        model.onlyKey = "\(model.symbol)\(model.priceTime)"
                        //缓存分时线
                        try! realm.write {
                            realm.add(model, update: true)
                        }
                    }
                }
            })
        })
    }
    
    //缓存数据
    class func cacheKChartModels(chart: ChartModel) {
        let _ = autoreleasepool(invoking: {
            
            queue.async(execute: {
                if chart.priceinfo == nil || chart.priceinfo?.count == 0 {
                    return
                }
                let realm = try! Realm()
                let firstModel = chart.priceinfo!.first
                let queryStr = NSPredicate.init(format: "symbol = %@",firstModel!.symbol)
                let result = realm.objects(KLineChartModel.self).filter(queryStr).filter("chartType = \(chart.chartType)")
                let goodMaxTime: Int = result.max(ofProperty: "priceTime") ?? 0
                let goodMinTime: Int = result.min(ofProperty: "priceTime") ?? 0
                for (_, model) in chart.priceinfo!.enumerated() {
                    if model.priceTime > goodMaxTime || model.priceTime < goodMinTime{
                        model.onlyKey = "\(model.symbol)\(model.priceTime)"
                        model.chartType = chart.chartType
                        //缓存分时线
                        try! realm.write {
                            realm.add(model, update: true)
                        }
                    }
                }
            })
        })
    }
    
    
    //读取分时数据
    class func queryTimelineModels(fromTime: Int, toTime: Int, goodType: String, complete: @escaping CompleteBlock){
        let _ = autoreleasepool(invoking: {
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "symbol = %@",goodType)
            let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime").filter(queryStr).filter("priceTime > \(fromTime)")
            for model in result {
                models.append(model)
            }
            complete(models as AnyObject?)
            print("读取分时数据===========================\(Thread.current)")
        })
    }
    
    //读取k线数据
    class func queryKLineModels(type: KLineType, fromTime: Int, toTime: Int, goodType: String, complete: @escaping CompleteBlock){
        let _ = autoreleasepool(invoking: {
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "symbol = %@",goodType)
            let result = realm.objects(KLineChartModel.self).sorted(byProperty: "priceTime").filter("priceTime > \(fromTime)").filter(queryStr).filter("chartType = \(type.rawValue)")
            for model in result {
                models.append(model)
            }
            complete(models as AnyObject?)
            print("读取\(type)K分时数据===========================\(Thread.current)")
        })
    }
   
}
//    //缓存K线模型
//    class func cacheKLineModels(klineType: KLineType, goodType: String) {
//        let _ = autoreleasepool(invoking: {
//            queue.async(execute: {
//                let realm = try! Realm()
//                let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
//                let queryTypeStr = NSPredicate.init(format: "klineType = %d",klineType.rawValue)
//                let goodMaxTime: Int = realm.objects(KLineChartModel.self).filter(queryStr).filter(queryTypeStr).max(ofProperty: "priceTime") ?? 0
//                queryModels(type: klineType, goodType: goodType, minTime: goodMaxTime)
//            })
//        })
//    }
//
//    //查询某种商品（goodType）的在某个时间段内（minTime）的某种K线（type）的分时数据来进行计算
//    class func queryModels(type: KLineType, goodType: String, minTime: Int){
//        let margin = type.rawValue * 60
//        var min = minTime > Int(Date.startTimestemp()) ? minTime : Int(Date.startTimestemp())
//        var max = min + margin
//        let current = Int(Date.nowTimestemp())
//        while max < current {
//            queryModel(type: type, goodType: goodType, fromTime: min, toTime: max)
//            min = max
//            max = min + margin
//        }
//    }
//
//    //查询某个时间段的K线数据并计算出该时间段的K线模型缓存起来
//    class func queryModel(type: KLineType,goodType: String, fromTime: Int, toTime: Int) {
//        let realm = try! Realm()
//        let queryStr = NSPredicate.init(format: "goodType = %@",goodType)
//        let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime").filter(queryStr).filter("priceTime > \(fromTime)").filter("priceTime < \(toTime)")
//
//        var resultModel: KLineChartModel?
//        for (index, model) in result.enumerated() {
//            if index == 0 {
//                resultModel = KLineChartModel()
//                resultModel!.priceTime = model.priceTime
//                resultModel!.exchangeName = model.exchangeName
//                resultModel!.platformName = model.platformName
//                resultModel!.currentPrice = model.currentPrice
//                resultModel!.change = model.change
//                resultModel!.openingTodayPrice = model.openingTodayPrice
//                resultModel!.closedYesterdayPrice = model.closedYesterdayPrice
//                resultModel!.highPrice = resultModel!.currentPrice
//                resultModel!.lowPrice = resultModel!.currentPrice
//                resultModel!.openPrice = resultModel!.currentPrice
//                resultModel!.klineType = type.rawValue
//            }else{
//                //收盘价
//                if index == result.count - 1 {
//                    resultModel?.closePrice = model.currentPrice
//                    resultModel?.onlyKey = "\(goodType)\(model.priceTime)"
//                }
//                //最高价
//                if resultModel!.highPrice < model.currentPrice {
//                    resultModel!.highPrice = model.currentPrice
//                }
//                //最低价
//                if resultModel!.lowPrice > model.currentPrice {
//                    resultModel!.lowPrice = model.currentPrice
//                }
//            }
//        }
//        if resultModel != nil {
//            try! realm.write {
//                realm.add(resultModel!, update: true)
//            }
//        }
//    }
