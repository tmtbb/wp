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
    static let isRepeate = true
    static let sha256Key = "t1@s#df!"
    static let md5Key = "yd1742653sd"
    static let pid = 1002
    static let klineCount: Double = 40
    static let progressDuration: Double = 1.5
    static let bundleId = "com.newxfin.goods"
    static let JapanMoney = "fx_sjpycnh"
    static let ErrorDomain = "com.newxfin.goods"
    
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
        static let line = UIColor(rgbHex:0xf2f2f2)
        static let CMain = UIColor(rgbHex: 0x268dcf)		
        static let CGreen = UIColor(rgbHex: 0x009944)
        static let main = "main"
        static let background = "background"
        static let buyUp = "buyUp"
        static let buyDown = "buyDown"
        static let auxiliary = "auxiliary"
        static let lightBlue = "lightBlue"
    };
   
    
    class Network {
        #if true //是否测试环境
        static let TcpServerIP:String = "139.224.34.22";
        static let TcpServerPort:UInt16 = 16205
        static let TttpHostUrl:String = "http://139.224.34.22";
        #else
        static let TcpServerIP:String = "122.144.169.217";
        static let TcpServerPort:UInt16 = 16205;
        static let HttpHostUrl:String = "http://122.144.169.217";
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ofr5nvpm7.bkt.clouddn.com/"
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
        static let AccessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token"
        static let Appid = "wx9dc39aec13ee3158" //wx54be5296e7826e5a
        static let Secret =  "1e372a173a248fb1b5c88d24236ef3b3"//"49961b15569b08556d9ef5815a89c0b4"
        static let ErrorCode = "ErrorCode"
        static let wechetUserInfo = "https://api.weixin.qq.com/sns/userinfo"
    }
    
    class WechatPay {
        static let WechatKeyErrorCode = "WechatKeyErrorCode"
    }
    
    class UnionPay {
        static let UnionErrorCode = "UnionErrorCode"
    }
    
    class NotifyDefine {
        static let jumpToDealList = "jumpToDealList"
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
    
    enum SegueIndentifier:String{
        case drawCashToBankListSegue = "DrawCashToBankListSegue"
        case wechatToBingPhone = "wechatToBingPhone"
        case rechargeToBankListSegue = "RechargeToBankListSegue"
    }
  
}
