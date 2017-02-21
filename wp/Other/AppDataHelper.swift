
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
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(initSelectKlineChartData), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(initLineChartData), userInfo: nil, repeats: true)
        initProductData()
        initErrorCode()
        checkTokenLogin()
    }
    //请求商品数据
    func initProductData() {
        var allProducets: [ProductModel] = []
        AppAPIHelper.deal().products(pid: 0, complete: {[weak self](result) -> ()? in
            self?.hurtTimer?.invalidate()
            if let products: [ProductModel] = result as! [ProductModel]?{
                //拼接所有商品
                allProducets += products
                //商品分类
                self?.checkAllProductKinds(allProducts: allProducets)
                DealModel.share().allProduct = allProducets
                //默认选择商品
                if allProducets.count > 0{
                    DealModel.share().selectProduct = allProducets[0]
                }
                self?.initAllKlineChartData()
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
    //根据商品分时数据
    func initLineChartData(){
        for product in DealModel.share().productKinds {
//        if let product = DealModel.share().selectProduct {
            let max = KLineModel.maxTime(type: .miu, symbol:product.symbol)
            if max > Date.nowTimestemp(){
                return
            }
            let startTime = max > Date.startTimestemp() ? max+300 : Date.startTimestemp()
            lineChartData(product: product, fromTime: startTime)
        }
    }
    func lineChartData(product: ProductModel, fromTime: Double){
        let param = KChartParam()
        param.symbol = product.symbol
        param.exchangeName = product.exchangeName
        param.platformName = product.platformName
        param.aType = 4
        param.startTime = Int64(fromTime)
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
    //根据商品请求K线数据
    func initAllKlineChartData() {
        initKLineChartData(type: .miu5)
        initKLineChartData(type: .miu15)
        initKLineChartData(type: .miu30)
        initKLineChartData(type: .miu60)
    }
    func initSelectKlineChartData() {
        let type = DealModel.share().klineTye
        initKLineChartData(type: type)
    }
    func initKLineChartData(type: KLineModel.KLineType) {
        if type == .miu{
            return
        }
        for product in DealModel.share().productKinds {
//        if let product = DealModel.share().selectProduct {
            let max = KLineModel.maxTime(type: type, symbol:product.symbol)
            if max > Date.nowTimestemp(){
                return
            }
            let startTime = max > Date.startTimestemp() ? max+Double(type.rawValue*5) : Date.startTimestemp()
            kLineChartData(type: type, product: product, fromTime: startTime)
        }
    }
    func kLineChartData(type: KLineModel.KLineType, product: ProductModel, fromTime: Double) {
        let param = KChartParam()
        param.symbol = product.symbol
        param.exchangeName = product.exchangeName
        param.platformName = product.platformName
        param.chartType = type.rawValue
        param.startTime = Int64(fromTime)
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
    
    //获取错误信息
    func initErrorCode() {
        
        AppAPIHelper.commen().errorCode(complete: { (result) -> ()? in
            if let errorDic: NSDictionary = result as? NSDictionary{
                let path = Bundle.main.path(forResource: "errorcode.plist", ofType:nil)
                let success = errorDic.write(toFile: path!, atomically: true)
                print(success ? "错误码写入成功" : "错误码写入失败")
            }
            return nil
        }, error: nil)
    }
}
