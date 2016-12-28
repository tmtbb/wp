//
//  UserModel.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
//import RealmSwift
class UserModel: BaseModel  {
    private static var model: UserModel = UserModel()
    class func share() -> BaseModel {
        return model
    }
    
//    var currenUser: UserInfo?
//    // 获取某个用户信息
//    class func userInfo(userId: Int) -> UserInfo {
//        let realm = try! Realm()
//        let user = realm.objects(UserInfo.self).filter("userId = \(userId)").first
//        if user != nil{
//            return user!
//        }else{
//            return UserInfo()
//        }
////    }
//    // 更新用户信息
//    class func upateUserInfo(user: UserInfo){
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(user, update: true)
//        }
//    }
    
}
