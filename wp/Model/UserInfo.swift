//
//  UserInfo.swift
//  wp
//
//  Created by 木柳 on 2016/12/27.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

import RealmSwift
class UserInfoModel: BaseModel {
    var userinfo: UserInfoModel?
    var id: Int = 0
    var screenName: String?
    var memberId: String?
    var memberName: String?
    var agentId: String?
    var agentName: String?
    var avatarLarge: String?
    var balance: Int = 0
    var token: String?
    
    func convertToUserInfo() -> UserInfo {
        let user = UserInfo()
        let r = Mirror.init(reflecting: user)
        let mr = Mirror.init(reflecting: self)
        for mrChild in mr.children {
            for var rChild in r.children {
                if rChild.label == mrChild.label {
                   rChild.value = mrChild.value
                }
            }
        }
        return user
    }
    
}

class UserInfo: Object {
    dynamic var id: Int = 0
    dynamic var screenName: String?
    dynamic var memberId: String?
    dynamic var memberName: String?
    dynamic var agentId: String?
    dynamic var agentName: String?
    dynamic var avatarLarge: String?
    dynamic var balance: Int = 0
    override static func primaryKey() -> String?{
        return "id"
    }
}


