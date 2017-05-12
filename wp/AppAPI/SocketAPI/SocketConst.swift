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
        // 获取图片上传token
        case imageToken = 1047
        // 错误码
        case errorCode = 0
        // 登录
        case login = 3003
        // 微信登录
        case wechatLogin = 3013
        // 绑定手机号
        case bingPhone = 3015
        // 注册
        case register = 3001
        // 重设密码
        case repwd = 3005
        // 声音验证码
        case voiceCode = 1006
        // 设置用户信息
        case userInfo = 10010
        //设置账号信息
        case accountNews = 1007
        //获取个人信息
        case getUserinfo = 1001
        //每天的数据
        case accinfo = 3007
        case tokenLogin = 3009
        //银行卡列表
        case bankcardList = 8003
        //银行卡详情
        case bingcard = 8005
        //解绑银行卡
        case unbindcard = 8007
        //获取银行卡名称
        case getbankname = 8009
        //获取验证码
        case verifycode = 3011
        //提现详情
        case withdrawDetail = 101
        // 我的晒单
        case userShare = 1020
        // 充值列表
        case rechageList = 6003
        // 充值详情
        case recharge = 10012
        // 提现列表
        case withdrawList = 6005
        //仓位列表
        case currentDeals = 5005
        //历史仓位列表
        case historyDeals = 6001
        //建仓
        case buildDeal = 5003
        //商品列表
        case products = 5001
        //当前K线数据
        case kChart = 4005
        //当前分时数据
        case timeline = 4003
        //当前报价
        case realtime = 4001
        //交易总概况
        case totalHistroy = 6010
        //航运仓位
        case position = 5007
        //收益选择
        case benifity = 6007
        //余额
        case balance = 7002
        //easyPay充值
        case easypayRecharge = 7039
        //easyPay提现
        case easypayWithDraw = 7045
        //更新版本
        case update = 3017
    }
    enum type:UInt8 {
        case error  = 0
        case wp     = 1
        case chat   = 2
        case user   = 3
        case time   = 4
        case deal   = 5
        case operate = 6
        case recharge = 7
        case drawcash = 8
    }
    
    enum aType:UInt8 {
        case shares = 1 //股票
        case spot = 2   //现货
        case futures = 3   //期货
        case currency = 4   //外汇
    }
    
    class Key {
        static let timeStamp = "timeStamp"
        static let token = "token"
        static let vToken = "vToken"
        static let uid = "uid"
        static let phone = "phone"
        static let id = "id"
        static let handle = "handle"
        static let nickname = "nickname"
        static let openid = "openid"
        static let aType = "aType"
        static let type = "type"
        static let verifyType = "verifyType"
        static let pwd = "pwd"
        static let headimgurl = "headimgurl"
        static let symbolInfos = "symbolInfos"
        static let source = "source"
        static let appid = "appid"
        static let accessToken = "accessToken"
        static let exchangeName = "exchangeName"
        static let secret = "secret"
        static let grant_type = "grant_type"
        static let platformName = "platformName"
        static let symbol = "symbol"
    }
    
    
}
