//
//  AppDataHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class AppDataHelper: NSObject {
    fileprivate static var helper = AppDataHelper()
    class func instance() -> AppDataHelper{
        return helper
    }
    //请求商品数据
    func initProductData() {
        var allProducets: [ProductModel] = []
        AppAPIHelper.deal().products(pid: 0, complete: {(result) -> ()? in
            if let products: [ProductModel] = result as! [ProductModel]?{
                allProducets += products
                DealModel.share().allProduct = allProducets
                if allProducets.count > 0{
                    DealModel.share().selectProduct = allProducets[0]
                }
            }
            return nil
        }) {[weak self](error) -> ()? in
            let _ = self?.delay(15, task: {
                self?.initProductData()
            })
            return nil
        }
    }
    //根据商品数据请求k线数据
    func initLineChartData(product: ProductModel){
        let param = KChartParam()
        param.goodType = product.typeCode
        param.exchangeName = product.exchangeName
        param.platformName = product.platformName
        
        AppAPIHelper.deal().timeline(param: param, complete: {(result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel]{
                KLineModel.cacheTimelineModels(models: models, goodType:param.goodType)
                KLineModel.cacheKTimelimeModels()
            }
            return nil
        }, error: { (error) ->()? in
            SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
            return nil
        })
    }
    //验证token登录
    
    
}
