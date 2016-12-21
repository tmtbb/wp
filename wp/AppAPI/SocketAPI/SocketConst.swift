//
//  SockOpcode.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class SocketConst: NSObject {
    enum OPCode:UInt16 {
        // 心跳包
        case heart = 1000
        case GetImageToken = 1047
    }
    enum type:UInt8 {
        case error = 0
        case user = 1
        case chat = 2
    }
    
    class Key {
        static let last_id = "last_id_"
        static let count = "count_"
        static let share_id = "share_id_"
        static let page_type = "page_type_"
        static let uid = "uid_"
        static let from_uid = "from_uid_"
        static let to_uid = "to_uid_"
        static let order_id = "order_id_"
        static let order_status = "order_status_"
        static let change_type = "change_type_"
        static let skills = "skills_"
        //WXKey
        static let appid = "appid"
        static let secret = "secret"
        static let code = "code"
        static let grant_type = "grant_type"
    }
    
    
}
