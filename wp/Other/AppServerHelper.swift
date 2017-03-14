//
//  AppServerHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Alamofire

class AppServerHelper: NSObject , WXApiDelegate{
    fileprivate static var helper = AppServerHelper()
    var feedbackKid: YWFeedbackKit?
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        initFeedback()
        initFabric()
        wechat()
    }
    
    //阿里百川
    func initFeedback() {
        feedbackKid = YWFeedbackKit.init(appKey: "23519848")
    }
    
    //Fabric
    func initFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    //友盟
    fileprivate func umapp() {
        UMAnalyticsConfig.sharedInstance().appKey = AppConst.UMAppkey
        UMAnalyticsConfig.sharedInstance().channelId = ""
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        //version标识
        let version: String? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        MobClick.setAppVersion(version)
        //日志加密设置
        MobClick.setEncryptEnabled(true)
        //使用集成测试服务
        MobClick.setLogEnabled(true)
    }
    
    //个推
    func pushMessageRegister() {
        //注册消息推送
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () in
            
            #if true
                GeTuiSdk.start(withAppId: "d2YVUlrbRU6yF0PFQJfPkA", appKey: "yEIPB4YFxw64Ag9yJpaXT9", appSecret: "TMQWRB2KrG7QAipcBKGEyA", delegate: nil)
            #endif
            
            let notifySettings = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
            UIApplication.shared.registerForRemoteNotifications()
            
        })
    }
    
    //MARK: --Wechat
    fileprivate func wechat() {
        WXApi.registerApp("wx9dc39aec13ee3158")
    }
    func onResp(_ resp: BaseResp!) {
        //微信登录返回
        if resp.isKind(of: SendAuthResp.classForCoder()) {
            let authResp:SendAuthResp = resp as! SendAuthResp
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: NSNumber.init(value: resp.errCode), userInfo:nil)
            if authResp.errCode == 0{
                let param = [SocketConst.Key.appid : AppConst.WechatKey.Appid,
                             SocketConst.Key.code : authResp.code,
                             SocketConst.Key.secret : AppConst.WechatKey.Secret,
                             SocketConst.Key.grant_type : "authorization_code"]
                Alamofire.request(AppConst.WechatKey.AccessTokenUrl, method: .get, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (result) in
                })
            }
            return
        }
        
        // 支付返回
        if resp.isKind(of: PayResp.classForCoder()) {
            let authResp:PayResp = resp as! PayResp
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatPay.WechatKeyErrorCode), object: NSNumber.init(value: authResp.errCode), userInfo:nil)
            
            return
        }
        
    }
}
