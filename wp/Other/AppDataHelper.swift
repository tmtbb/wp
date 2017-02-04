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
    
    func initData() {
        initProductData()
        checkTokenLogin()
    }
    //请求商品数据
    func initProductData() {
        var allProducets: [ProductModel] = []
        AppAPIHelper.deal().products(pid: 0, complete: {(result) -> ()? in
            if let products: [ProductModel] = result as! [ProductModel]?{
                //拼接所有商品
                allProducets += products
                DealModel.share().allProduct = allProducets
                //默认选择商品
                if allProducets.count > 0{
                    DealModel.share().selectProduct = allProducets[0]
                }
            }
            return nil
        }) {(error) -> ()? in
            SVProgressHUD.showErrorMessage(ErrorMessage: "商品数据获取失败，请稍候再试", ForDuration: 1.5, completion: nil)
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
