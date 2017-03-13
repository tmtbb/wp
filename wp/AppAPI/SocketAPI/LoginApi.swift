//
//  LoginApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol LoginApi {
    //登录
    func login(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    //测试登录
    func testlogin(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    //token登录
    func tokenLogin(uid: Int, token: String, complete: CompleteBlock?, error: ErrorBlock?)
    //注册
    func register(phone: String, code: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    //重置密码
    func repwd(phone: String, type: Int, pwd: String, code: String, complete: CompleteBlock?, error: ErrorBlock?)
    //获取声音验证码
    func voiceCode(phone: String, complete: CompleteBlock?, error: ErrorBlock?)
}
