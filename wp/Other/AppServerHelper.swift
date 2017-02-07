//
//  AppServerHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class AppServerHelper: NSObject {
    fileprivate static var helper = AppServerHelper()
    var feedbackKid: YWFeedbackKit?
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        initFeedback()
    }
    
    //阿里百川
    func initFeedback() {
        feedbackKid = YWFeedbackKit.init(appKey: "")
    }
}
