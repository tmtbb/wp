//
//  UserModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
class UserModel: BaseModel  {
    private static var model: UserModel = UserModel()
    class func share() -> UserModel {
        return model
    }
    var registerUser: UserInfo?
    var currentUser: UserInfo?
    var code:String?
    var phone:String?
    var forgetPwd:Bool = false
    
    
    static var token: String?
    static var currentUserId: Int = 0
    // 获取某个用户信息
    class func userInfo(userId: Int) -> UserInfo {
        let realm = try! Realm()
        let user = realm.objects(UserInfo.self).filter("id = \(userId)").first
        if user != nil{
            return user!
        }else{
            return UserInfo()
        }
    }
    // 更新用户信息
    class func upateUserInfo(userObject: AnyObject){
        if let model = userObject as? UserInfoModel {
            token = model.token
            currentUserId = model.userinfo?.id ?? 0
            let user = model.convertToUserInfo()
            let realm = try! Realm()
            try! realm.write {
                realm.add(user, update: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
            }
        }
        
    }
    // 登录
    
}
