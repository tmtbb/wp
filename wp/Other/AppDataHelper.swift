
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
    
    private var hurtTimer: Timer?
    
    func initData() {
        hurtTimer = Timer.scheduledTimer(timeInterval: 15 , target: self, selector: #selector(initProductData), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(initAllData), userInfo: nil, repeats: true)
        initProductData()
        checkTokenLogin()
    }
    //请求商品数据
    func initProductData() {
        var allProducets: [ProductModel] = []
        AppAPIHelper.deal().products(pid: 0, complete: {[weak self](result) -> ()? in
            self?.hurtTimer?.invalidate()
            if let products: [ProductModel] = result as! [ProductModel]?{
                //拼接所有商品
                allProducets = products
                //商品分类
                self?.checkAllProductKinds(allProducts: allProducets)
                DealModel.share().allProduct = allProducets
                //默认选择商品
                if allProducets.count > 0{
                    DealModel.share().selectProduct = allProducets[0]
                }
                //缓存k线数据
                self?.initLineChartData(first: true)
                self?.initKLineModel(first: true)

            }else{
    
            }
            return nil
        }) {(error) -> ()? in
            SVProgressHUD.showErrorMessage(ErrorMessage: "商品数据获取失败，请稍候再试", ForDuration: 1.5, completion: nil)
            return nil
        }
    }
    
    //对所有商品进行分类
    func checkAllProductKinds(allProducts: [ProductModel]) {
        for product in allProducts {
            if DealModel.share().productKinds.count == 0 {
                DealModel.share().productKinds.append(product)
            }else{
                var isContent = false
                for kind in DealModel.share().productKinds{
                    if product.symbol == kind.symbol {
                        isContent = true
                    }
                }
                if isContent == false{
                    DealModel.share().productKinds.append(product)
                }
            }
        }
    }
    
    //预加载所有k线数据
    func initAllData() {
        initLineChartData(first: false)
        initKLineModel(first: false)
    }
    //根据商品分时数据
    func initLineChartData(first: Bool){
        if first {
            for product in DealModel.share().productKinds{
                let param = KChartParam()
                param.symbol = product.symbol
                param.exchangeName = product.exchangeName
                param.platformName = product.platformName
                param.aType = 4
                AppAPIHelper.deal().timeline(param: param, complete: {(result) -> ()? in
                    if let models: [KChartModel] = result as? [KChartModel]{
                        KLineModel.cacheTimelineModels(models: models)
                    }
                    return nil
                }, error: { (error) ->()? in
                    SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
                    return nil
                })
            }
        }
        
        if let product = DealModel.share().selectProduct {
            let param = KChartParam()
            param.symbol = product.symbol
            param.exchangeName = product.exchangeName
            param.platformName = product.platformName
            param.aType = 4
            AppAPIHelper.deal().timeline(param: param, complete: {(result) -> ()? in
                if let models: [KChartModel] = result as? [KChartModel]{
                    KLineModel.cacheTimelineModels(models: models)
                }
                return nil
            }, error: { (error) ->()? in
                SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
                return nil
            })
        }
    }
    //根据商品请求K线数据
    func initKLineModel(first: Bool) {
        initKLineChartData(type: .miu5, first: first)
        initKLineChartData(type: .miu15, first: first)
        initKLineChartData(type: .miu30, first: first)
        initKLineChartData(type: .miu60, first: first)
    }
    func initKLineChartData(type: KLineModel.KLineType, first: Bool) {
        if first {
            for product in DealModel.share().productKinds {
                let param = KChartParam()
                param.symbol = product.symbol
                param.exchangeName = product.exchangeName
                param.platformName = product.platformName
                param.chartType = type.rawValue
                AppAPIHelper.deal().kChartsData(param: param, complete: { (result) -> ()? in
                    if let chart: ChartModel = result as? ChartModel{
                        KLineModel.cacheKChartModels(chart: chart)
                    }
                    return nil
                }, error:{ (error) ->()? in
                    SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
                    return nil
                })
            }
        }
        
        if let product = DealModel.share().selectProduct {
            let param = KChartParam()
            param.symbol = product.symbol
            param.exchangeName = product.exchangeName
            param.platformName = product.platformName
            param.chartType = type.rawValue
            AppAPIHelper.deal().kChartsData(param: param, complete: { (result) -> ()? in
                if let chart: ChartModel = result as? ChartModel{
                    KLineModel.cacheKChartModels(chart: chart)
                }
                return nil
            }, error:{ (error) ->()? in
                SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
                return nil
            })
        }
    }
    
    
    //验证token登录
    func checkTokenLogin() {
        //token是否存在
        if let token = UserDefaults.standard.value(forKey: SocketConst.Key.token){
            if let phone = UserDefaults.standard.value(forKey: SocketConst.Key.phone){
                AppAPIHelper.login().tokenLogin(phone: phone as! String, token: token as! String, complete: { [weak self]( result) -> ()? in
                    //存储用户信息
                    if let model = result as? UserInfoModel {
                        if let token = model.token{
                            //更新token
                            UserDefaults.standard.setValue(token, forKey: SocketConst.Key.token)
                        }
                       
                        if let user = model.userinfo {
                            UserDefaults.standard.setValue(user.uid, forKey: SocketConst.Key.id)
                            UserModel.share().currentUser = UserModel.getCurrentUser()
                        }
                    }else{
                       self?.clearUserInfo()
                    }
                    return nil
                }, error: { (error) ->()? in
                        SVProgressHUD.showErrorMessage(ErrorMessage: error.description, ForDuration: 1, completion: nil)
                        return nil
                })
            }
        }
    }
    //清楚用户数据
    func clearUserInfo() {
        UserDefaults.standard.removeObject(forKey: SocketConst.Key.uid)
        UserDefaults.standard.removeObject(forKey: SocketConst.Key.token)
        UserModel.share().currentUser = nil
    }

}
