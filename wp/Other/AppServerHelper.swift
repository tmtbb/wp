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
class AppServerHelper: NSObject {
    fileprivate static var helper = AppServerHelper()
    var feedbackKid: YWFeedbackKit?
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        initFeedback()
        initFabric()
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
}
