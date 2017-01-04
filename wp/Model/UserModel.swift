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
    var token: String?
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
            let user = model.convertToUserInfo()
            let realm = try! Realm()
            try! realm.write {
                realm.add(user, update: true)
            }
        }
    }
    // 登录
    
}
