//
//  AppAPIHelper.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class AppAPIHelper: NSObject {
    
    fileprivate static var _commenApi = CommenSocketApi()
    class func commen() -> CommenApi{
        return _commenApi
    }
    
    fileprivate static var _loginApi = LoginSocketApi()
    class func login() -> LoginApi{
        return _loginApi
    }
    
    fileprivate static var _shareApi = ShareSocketApi()
    class func share() -> ShareApi{
        return _shareApi
    }
    
    fileprivate static var _dealApi = DealSocketApi()
    class func deal() -> DealApi{
        return _dealApi
    }
    
    fileprivate static var _homeApi = HomeSocketApi()
    class func home() -> HomeApi{
        return _homeApi
    }
    
    fileprivate static var _userApi = UserSocketApi()
    class func user() -> UserApi{
        return _userApi
    }
}

