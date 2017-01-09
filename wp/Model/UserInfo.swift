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
    var token: String?
    var uid: Int = 0
    var screenName: String?
    var memberId: String?
    var memberName: String?
    var agentId: String?
    var agentName: String?
    var avatarLarge: String?
    var balance: Int = 0
    var gender: Int = 0
    var nickname: String?
    var phone: String?
}

class UserInfo: Object {
    dynamic var id: Int = 0
    dynamic var uid: Int = 0
    dynamic var screenName: String?
    dynamic var memberId: String?
    dynamic var memberName: String?
    dynamic var agentId: String?
    dynamic var agentName: String?
    dynamic var avatarLarge: String?
    dynamic var balance: Int = 0
    dynamic var gender: Int = 0
    dynamic var nickname: String?
    dynamic var phone: String?
    
    override static func primaryKey() -> String?{
        return "uid"
    }
}


