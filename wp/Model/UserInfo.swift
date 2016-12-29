//
//  UserInfo.swift
//  wp
//
//  Created by 木柳 on 2016/12/27.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

import RealmSwift
class UserInfo: Object {
   dynamic var uName: String?
   dynamic var uPhone: String?
   dynamic var uId: Int = 0
   dynamic var headerUrl: String?
   
    override static func primaryKey() -> String?{
        return "uId"
    }

}
