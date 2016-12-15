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
        // 请求登录
        case login = 1001
        //验证手机短信
        case smsVerify = 1019
        //验证手机验证码
        case verifyCode = 1101
        //注册
        case register = 1021
        //重置密码
        case nodifyPasswrod = 1011
        //修改用户信息
        case nodifyUserInfo = 1023
        //获取图片token
        case getImageToken = 1047
        //获取用户余额
        case userCash = 1067
        //认证用户头像
        case authUserHeader = 1091
        //获取用户的银行卡信息
        case userBankCards = 1097
        //校验提现密码
        case checkDrawCashPassword = 1087
        //提现
        case drawCash = 1103
        //提现详情
        case drawCashDetail = 0004
        //提现记录
        case drawCashRecord = 1105
        //设置默认银行卡
        case defaultBankCard = 1099
        //添加新的银行卡
        case newBankCard = 1095
        //获取所有技能标签
        case allSkills = 1041
        //获取身份认证进度
        case authStatus = 1057
        //上传身份认证信息
        case authUser = 1055
        //设置/修改支付密码
        case drawCashPassword = 1089
        //V领队服务
        case serviceList = 1501
        //更新V领队服务
        case updateServiceList = 1503
        //技能分享列表
        case skillShareList = 1071
        //技能分享详情
        case skillShareDetail = 1073
        //技能分享评论列表
        case skillShareComment = 1075
        //技能分享预约
        case skillShareEnroll = 1077
        /**
         订单列表
         */
        case orderList = 1505

        //订单详情
        case orderDetail = 1507
        
        /**
         操作技能标签
         */
        case handleSkills = 1509
        //商务分享类别
        case tourShareType = 1059
        //商务分享列表
        case tourShareList = 1061
        //商务分享详情
        case tourShareDetail = 1065
        //上传照片到照片墙
        case uploadPhoto2Wall = 1107
        //获取照片墙
        case photoWall = 1109
        /**
         修改订单状态
         */
        case modfyOrderStatus = 2011
        
        case loginRet = 1002
        case userInfo = 1013
        //发送chat消息
        case chatSendMessage = 2003
        //收到chat消息
        case chatReceiveMessage = 2004
        //获取chat离线消息
        case chatOfflineRequestMessage = 2025
        case chatOfflineReceiveMessage = 2006
        case updateDeviceToken = 1031
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
    }
}
