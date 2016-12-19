//
//  AppConfig.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit

typealias CompleteBlock = (AnyObject?) ->()
typealias ErrorBlock = (NSError) ->()

class AppConst {
    
    class Color {
        static let C0 = UIColor(rgbHex:0x131f32)
        static let CR = UIColor(rgbHex:0xb82525)
        static let C1 = UIColor.black
        static let C2 = UIColor(rgbHex:0x666666)
        static let C3 = UIColor(rgbHex:0x999999)
        static let C4 = UIColor(rgbHex:0xaaaaaa)
        static let C5 = UIColor(rgbHex:0xe2e2e2)
        static let C6 = UIColor(rgbHex:0xf2f2f2)
    };
     class SystemFont {
        static let S1 = UIFont.systemFont(ofSize: 18)
        static let S2 = UIFont.systemFont(ofSize: 15)
        static let S3 = UIFont.systemFont(ofSize: 13)
        static let S4 = UIFont.systemFont(ofSize: 12)
        static let S5 = UIFont.systemFont(ofSize: 10)
        static let S14 = UIFont.systemFont(ofSize: 14)
    };
    
    class Event {
        static let login = "login"
        static let sign_btn = "sign_btn"
        static let sign_confrim = "sign_confrim"
        static let sign_last = "sign_last"
        static let sign_next = "sign_next"
        static let bank_add = "bank_add"
        static let bank_select = "bank_select"
        static let drawcash = "drawcash"
        static let drawcash_pwd = "drawcash_pwd"
        static let drawcash_total = "drawcash_total"
        static let message_send = "message_send"
        static let order_accept = "order_accept"
        static let order_aply = "order_aply"
        static let order_unaply = "order_unaply"
        static let order_chat = "order_chat"
        static let order_list = "order_list"
        static let order_refuse = "order_refuse"
        static let server_add = "server_add"
        static let server_addPicture = "server_addPicture"
        static let server_beauty = "server_beauty"
        static let server_cancelAdd = "server_cancelAdd"
        static let server_mark = "server_mark"
        static let server_next = "server_next"
        static let server_picture = "server_picture"
        static let server_sure = "server_sure"
        static let server_delete = "server_delete"
        static let server_update = "server_update"
        static let server_start = "server_start"
        static let server_end = "server_end"
        static let server_type = "server_type"
        static let server_price = "server_price"
        static let share_eat = "share_eat"
        static let share_fun = "share_fun"
        static let share_hotel = "share_hotel"
        static let share_phone = "share_phone"
        static let share_travel = "share_travel"
        static let skillshare_comment = "skillshare_comment"
        static let skillshare_detail = "skillshare_detail"
        static let user_anthuser = "user_anthuser"
        static let user_location = "user_location"
        static let user_logout = "user_logout"
        static let user_nickname = "user_nickname"
        static let user_question = "user_question"
        static let user_resetpwd = "user_resetpwd"
        static let user_sex = "user_sex"
        static let user_version = "user_version"
        static let user_icon = "user_icon"
        static let user_clearcache = "user_clearcache"
    }
    
    class Network {
        #if false //是否测试环境
        static let TcpServerIP:String = "103.40.192.101";
        static let TcpServerPort:UInt16 = 10001;
        static let TttpHostUrl:String = "http://61.147.114.78";
        #else
        static let TcpServerIP:String = "103.40.192.101";
        static let TcpServerPort:UInt16 = 10001;
        static let HttpHostUrl:String = "http://61.147.114.78";
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ofr5nvpm7.bkt.clouddn.com/"
    }
    class Text {
        static let PhoneFormatErr = "请输入正确的手机号"
        static let VerifyCodeErr  = "请输入正确的验证码"
        static let SMSVerifyCodeErr  = "获取验证码失败"
        static let PasswordTwoErr = "两次密码不一致"
        static let ReSMSVerifyCode = "重新获取"
        static let ErrorDomain = "com.yundian.viossvc"
        static let PhoneFormat = "^1[3|4|5|7|8][0-9]\\d{8}$"
        static let RegisterPhoneError = "输入的手机号已注册"
    }
    static let DefaultPageSize = 15
    
    enum Action:UInt {
        case callPhone = 10001
        case handleOrder = 11001
    }
    
    static let UMAppkey = "584a3eb345297d271600127e"
    
    class WechatKey {
        static let Scope = "snsapi_userinfo"
        static let State = "wpstate"
        static let AccessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code"
        static let Appid = "wxe9eb1211f11f0d02"
        static let Secret = "Secret"
        static let ErrorCode = "ErrorCode" 
    }
}
