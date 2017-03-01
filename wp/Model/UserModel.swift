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
    
    enum Movement: Int{
        case loginPass = 0
        case dealPass = 1
       
    }
    var currentUser: UserInfo? 
    var code:String?
    var phone:String?
    var codeToken:String = ""
    var timestamp:Int = 0
    var forgetPwd:Bool = false
    var forgetType:Movement?
    var token: String = UserDefaults.standard.value(forKey: SocketConst.Key.token) == nil ?  "" : UserDefaults.standard.value(forKey: SocketConst.Key.token) as! String
    var currentUserId: Int = 0
    // 获取某个用户信息
    class func userInfo(userId: Int) -> UserInfo? {
        if userId == 0 {
            return nil
        }
        
        let realm = try! Realm()
        let filterStr = "id = \(userId)"
        let user = realm.objects(UserInfo.self).filter(filterStr).first
        if user != nil{
            return user!
        }else{
            return nil
        }
    }
   
    
    //获取当前用户
    func getCurrentUser() -> UserInfo? {
        let id: Int? = UserDefaults.standard.value(forKey: SocketConst.Key.id) as? Int
        if id == nil{
            return nil
        }
        let user = UserModel.userInfo(userId:id!)
        if user != nil {
            return user
        }else{
            return nil
        }
    }
    
    //从服务端拉取用户信息
    func fetchUserInfo(phone: String, pwd: String) {
        AppAPIHelper.login().login(phone: phone, pwd: pwd, complete: { [weak self]( result) -> ()? in
            //存储用户信息
            if result != nil{
                self?.upateUserInfo(userObject: result!)
            }else{
                AppDataHelper.instance().clearUserInfo()
            }
            return nil
        }, error: { (error) in
                AppDataHelper.instance().clearUserInfo()
            return nil
        })
    }

    
    // 更新用户信息
    func upateUserInfo(userObject: AnyObject){
        if let model = userObject as? UserInfoModel {
            token = model.token!
            //存储token
            UserDefaults.standard.setValue(token, forKey: SocketConst.Key.token)
            if let user = model.userinfo {
                currentUserId = user.id
                //存储uid
                UserDefaults.standard.setValue(currentUserId, forKey: SocketConst.Key.id)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(user, update: true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
                    currentUser = getCurrentUser()
                }
            }
        }
    }

    // 更新用户某个字段
    class func updateUser(info: paramBlock?) {
        let realm = try! Realm()
        try! realm.write {
            info!(nil)
        }
    }
    

}
