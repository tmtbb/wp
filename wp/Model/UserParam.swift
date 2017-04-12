//
//  UserParam.swift
//  wp
//
//  Created by mu on 2017/4/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class UserParam: BaseModel {

}


class RegisterParam: BaseModel{
    var phone = ""
    var pwd = ""
    var vCode = ""
    var memberId = 0
    var agentId = ""
    var recommend = ""
    var timeStamp = 0
    var vToken = ""
}
