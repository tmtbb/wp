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
        // 获取分时信息
        case minDealInfo = 10001
        // 登录
        case login = 1001
        // 注册
        case register = 1021
        // 重设密码
        case repwd = 1004
        // 声音验证码
        case voiceCode = 1005
        // 设置用户信息
        case userInfo = 1006
        //设置账号信息
        case accountNews = 1007
        //流水列表
        case flowList = 1008
        //流水详情
        case flowDetails = 1009
        //银行卡列表
        case bankcardList = 1010
        //银行卡详情
        case bingcard = 1011
        //解绑银行卡
        case unbindcard = 1012
        //充值列表
        case creditlist = 1013
        //充值详情
        case creditdetail = 1014
        //银行卡提现
        case withdrawcash = 1015
        //提现列表
        case withdrawlist = 1016
        //提现详情
        case withdrawdetail = 1017
        // 我的晒单
        case userShare = 10010
         // 充值列表
        case rechageList = 10011
        // 充值详情
        case recharge = 10012
        // 提现列表
        case withdrawList = 10013
        // 提现
        case withdrawCash = 10014
        //仓位列表
        case currentDeals = 2000
        //仓位详情
        case currentDealDetail = 2001
        //历史仓位列表
        case historyDeals = 2002
        //历史仓位详情
        case historyDealDetail = 2003
        //建仓
        case buildDeal = 2004
        //平仓
        case sellOutDeal = 2005
        //修改持仓
        case changeDeal = 2006

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
        static let uid = "id"
        static let from_uid = "from_uid_"
        static let to_uid = "to_uid_"
        static let order_id = "order_id_"
        static let order_status = "order_status_"
        static let change_type = "change_type_"
        static let skills = "skills_"
        static let type = "type"
        static let phone = "phone"
        static let pwd = "pwd"
        static let code = "vCode"
        static let voiceCode = "voiceCode"
        static let appid = "appid"
        static let secret = "secret"
        static let grant_type = "grant_type"
        static let flowType = "flowType"
        static let startPos = "startPos"
        static let countNuber = "count"
        static let flowld = "flowld"
        static let bank = "bank"
        static let branchBank = "branchBank"
        static let province = "province"
        static let city = "city"
        static let cardNo = "cardNo"
        static let name = "name"
        static let bankId = "bankId"
        static let source = "source"
        static let memberId = "memberId"
        static let agentId = "agentId"
        static let recommend = "recommend"
        static let status = "status"
        static let pos = "pos"
        static let rid = "rid"
        static let money = "money"
        static let bld = "bld"
        static let password = "password"
        static let withdrawld = "withdrawld"
        static let id = "id"
        static let positionId = "positionId"
        static let token = "token"
        static let position = "position"
        static let price = "price"
    }
    
    
}
