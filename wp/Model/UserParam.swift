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
    var deviceId = UserModel.share().uuid
}

class BingPhoneParam: RegisterParam {
    var openid = ""
    var nickname = ""
    var headerUrl = ""
}

class LoginParam: BaseModel {
    var phone = ""
    var pwd = ""
    var source = 1
    var deviceId = UserModel.share().uuid
}

class WechatLoginParam: BaseModel {
    var openId = ""
    var source = 1
    var deviceId = UserModel.share().uuid
}

class ChecktokenParam: BaseParam{
    var source  = 1
}

class CheckPhoneParam: BaseParam{
    var type = 0
    var phone = ""
}

class ResetPwdParam: BaseParam{
    var phone = UserModel.share().phone!
    var pwd = ""
    var vCode = ""
    var type = 0
    var timestamp = 0
    var vToken = ""
}




