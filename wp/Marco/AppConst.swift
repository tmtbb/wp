//
//  AppConfig.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit

typealias CompleteBlock = (AnyObject?) ->()?
typealias ErrorBlock = (NSError) ->()?
typealias paramBlock = (AnyObject?) ->()?
//MARK: --正则表达
func isTelNumber(num: String)->Bool
{
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^1[3|4|5|7|8][0-9]\\d{8}$")
    return predicate.evaluate(with: num)
}


class AppConst {
    static let DefaultPageSize = 15
    static let UMAppkey = "584a3eb345297d271600127e"
    static let isMock = false
    static let sha256Key = "t1@s#df!"
    static let pid = 1002
    static let klineCount: Double = 30
    static let bundleId = "com.newxfin.goods"
    
    enum KVOKey: String {
        case selectProduct = "selectProduct"
        case allProduct = "allProduct"
        case currentUserId = "currentUserId"
        case balance = "balance"
    }
    
    enum NoticeKey: String {
        case logoutNotice = "LogoutNotice"
    }
    
    class Color {
        static let C0 = UIColor(rgbHex:0x131f32)
        static let CR = UIColor(rgbHex:0xb82525)
        static let C1 = UIColor.black
        static let C2 = UIColor(rgbHex:0x666666)
        static let C3 = UIColor(rgbHex:0x999999)
        static let C4 = UIColor(rgbHex:0xaaaaaa)
        static let C5 = UIColor(rgbHex:0xe2e2e2)
        static let C6 = UIColor(rgbHex:0xf2f2f2)
        //wp
        static let CMain = UIColor(rgbHex: 0x268dcf)
        static let CGreen = UIColor(rgbHex: 0x009944)

        static let main = "main"
        static let background = "background"
        static let buyUp = "buyUp"
        static let buyDown = "buyDown"
        static let auxiliary = "auxiliary"
        static let lightBlue = "lightBlue"
    };
     class SystemFont {
        static let S1 = UIFont.systemFont(ofSize: 18)
        static let S2 = UIFont.systemFont(ofSize: 15)
        static let S3 = UIFont.systemFont(ofSize: 13)
        static let S4 = UIFont.systemFont(ofSize: 12)
        static let S5 = UIFont.systemFont(ofSize: 10)
        static let S14 = UIFont.systemFont(ofSize: 14)
    };
    
    class Network {
        #if true //是否测试环境
        static let TcpServerIP:String = "61.147.114.87";
        static let TcpServerPort:UInt16 = 16005
        static let TttpHostUrl:String = "http://61.147.114.87";
        #else
        static let TcpServerIP:String = "192.168.8.131";
        static let TcpServerPort:UInt16 = 30001;
        static let HttpHostUrl:String = "http://192.168.8.131";

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
        static let ErrorDomain = "com.newxfin.goods"
        static let PhoneFormat = "^1[3|4|5|7|8][0-9]\\d{8}$"
        static let RegisterPhoneError = "输入的手机号已注册"
    }
    
    
    enum Action:UInt {
        case callPhone = 10001
        case handleOrder = 11001
    }
    
    enum BundleInfo:String {
        case CFBundleDisplayName = "CFBundleDisplayName"
        case CFBundleShortVersionString = "CFBundleShortVersionString"
        case CFBundleVersion = "CFBundleVersion"
    }

    class WechatKey {
        static let Scope = "snsapi_userinfo"
        static let State = "wpstate"
        static let AccessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code"
        static let Appid = "wx9dc39aec13ee3158"
        static let Secret = "Secret"
        static let ErrorCode = "ErrorCode" 
    }
    
    class WechatPay {
        static let WechatKeyErrorCode = "WechatKeyErrorCode"
    }
    
    class UnionPay {
        static let UnionErrorCode = "UnionErrorCode"
    }
    
    class NotifyDefine {
        
        static let jumpToMyMessage = "jumpToMyMessage"
        static let jumpToMyAttention = "jumpToMyAttention"
        static let jumpToMyPush = "jumpToMyPush"
        static let jumpToMyBask = "jumpToMyBask"
        static let jumpToDeal = "jumpToDeal"
        static let jumpToFeedback = "jumpToFeedback"
        static let jumpToProductGrade = "jumpToProductGrade"
        static let jumpToAttentionUs = "jumpToAttentionUs"
        static let jumpToMyWealtVC = "jumpToMyWealtVC"
        static let jumpToWithdraw = "jumoToWithdraw"
        static let jumpToRecharge = "jumpToRecharge"
        static let UpdateUserInfo = "UpdateUserInfo"
        static let BingPhoneVCToPwdVC = "BingPhoneVCToPwdVC"
        static let LoginToBingPhoneVC = "LoginToBingPhoneVC"
        static let RegisterToBingPhoneVC = "RegisterToBingPhoneVC"
        static let HistoryDealDetailVC = "HistoryDealDetailVC"
        static let QuitEnterClick = "QuitEnterClick"
        static let ChangeUserinfo = "ChangeUserinfo"
        static let BuyToMyWealtVC = "BuyToMyWealtVC"
        static let DealToMyWealtVC = "DealToMyWealtVC"
        static let SelectKind = "SelectKind"
        static let EnterBackground = "EnterBackground"
        static let RequestPrice = "RequestPrice"
    }
    
    
  
}
