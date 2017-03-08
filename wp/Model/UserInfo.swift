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
    var userinfo: UserInfo?
    var token: String?
}

class UserInfo: Object {
    dynamic var id: Int = 0
    dynamic var screenName: String?
    dynamic var memberId: String?
    dynamic var memberName: String?
    dynamic var agentId: String?
    dynamic var agentName: String?
    dynamic var avatarLarge: String?
    dynamic var balance: Double = 0
    dynamic var gender: Int = 0
    dynamic var nickname: String?
    dynamic var phone: String?
    dynamic var type: Int = 0
    override static func primaryKey() -> String?{
        return "id"
    }

}
class TotalHistoryModel: BaseModel {
    
    var profit:Double = 0.0
    var count:Int64 = 0
    var amount:Int64 = 0
}


class TransactionDetailModel: BaseModel {
    var allDataDict:[String : Array<PositionModel>] = [:]
    var dateArray:[String] = []
}

