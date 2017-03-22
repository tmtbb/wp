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
                        model.chartType = chart.chartType
                        model.onlyKey = "\(model.symbol)\(model.priceTime)\(model.chartType)"
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
//            let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime").filter(queryStr).filter("priceTime > \(fromTime)")
//            for  model in result {
//                models.append(model)
//            }
            let result = realm.objects(KChartModel.self).sorted(byProperty: "priceTime", ascending:false).filter(queryStr)
            for (index,model) in result.enumerated(){
                if index > Int(AppConst.klineCount){
                    break
                }
                models.insert(model, at: 0)
            }
            complete(models as AnyObject?)
        })
    }
    
    //读取k线数据
    class func queryKLineModels(type: KLineType, fromTime: Int, toTime: Int, goodType: String, complete: @escaping CompleteBlock){
        let _ = autoreleasepool(invoking: {
            var models: [KChartModel] = []
            let realm = try! Realm()
            let queryStr = NSPredicate.init(format: "symbol = %@",goodType)
//            let result = realm.objects(KLineChartModel.self).sorted(byProperty: "priceTime").filter("priceTime > \(fromTime)").filter(queryStr).filter("chartType = \(type.rawValue)")
//            for model in result{
//                models.append(model)
//            }
            
            let result = realm.objects(KLineChartModel.self).sorted(byProperty: "priceTime", ascending:false).filter(queryStr).filter("chartType = \(type.rawValue)")
            for (index,model) in result.enumerated(){
                if index > Int(AppConst.klineCount){
                    break
                }
                models.insert(model, at: 0)
            }
            complete(models as AnyObject?)
        })
    }
    
    //读取某种商品某种k线的最大值
    class func maxTime(type: KLineType, symbol:String) -> Double {
        let realm  = try! Realm()
        if type == .miu {
            let queryStr = NSPredicate.init(format: "symbol = %@",symbol)
            let result = realm.objects(KChartModel.self).filter(queryStr)
            return result.max(ofProperty: "priceTime") ?? 0
        }else{
            let queryStr = NSPredicate.init(format: "symbol = %@",symbol)
            let result = realm.objects(KLineChartModel.self).filter(queryStr).filter("chartType = \(type.rawValue)")
            return result.max(ofProperty: "priceTime") ?? 0
        }
    }
    
    //读取某种商品某种k线的最大值
    class func minTime(type: KLineType, symbol:String) -> Double {
        let realm  = try! Realm()
        if type == .miu {
            let queryStr = NSPredicate.init(format: "symbol = %@",symbol)
            let result = realm.objects(KChartModel.self).filter(queryStr)
            return result.min(ofProperty: "priceTime") ?? 0
        }else{
            let queryStr = NSPredicate.init(format: "symbol = %@",symbol)
            let result = realm.objects(KLineChartModel.self).filter(queryStr).filter("chartType = \(type.rawValue)")
            return result.min(ofProperty: "priceTime") ?? 0
        }
    }
   
}
