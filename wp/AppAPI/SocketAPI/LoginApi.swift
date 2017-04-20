//
//  LoginApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol LoginApi {
    //登录(模型)
    func login(param: LoginParam, complete: CompleteBlock?, error: ErrorBlock?)
    //token登录(模型)
    func tokenLogin(param: ChecktokenParam, complete: CompleteBlock?, error: ErrorBlock?)
    //微信登录(模型)
    func login(param: WechatLoginParam, complete: CompleteBlock?, error: ErrorBlock?)
    //微信登录(模型)
    func bingPhone(param: BingPhoneParam, complete: CompleteBlock?, error: ErrorBlock?)
    //注册（模型）
    func register(model:RegisterParam, complete: CompleteBlock?, error: ErrorBlock?)
    //重置密码(模型)
    func repwd(param: ResetPwdParam, complete: CompleteBlock?, error: ErrorBlock?)
}
