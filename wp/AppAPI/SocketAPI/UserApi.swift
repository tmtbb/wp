//
//  UserApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol UserApi {
    //设置用户信息
    func userInfo(user: UserInfo, complete: CompleteBlock?, error: ErrorBlock?)
    //流水列表
    func flowList(flowType: String, startPos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //流水详情
    func flowDetails(flowld: Int64, flowType: Int8, complete: CompleteBlock?, error: ErrorBlock?)
//    //用户信息
//    func accinfo(user: UserInfo, complete: CompleteBlock?, error: ErrorBlock?)
    
    //账户信息
    func accinfo(complete: CompleteBlock?, error: ErrorBlock?)
     //每天的数据
    func everyday(start: Int32,count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //银行卡列表
    func bankcardList(complete: CompleteBlock?, error: ErrorBlock?)
    //绑定银行卡
    func bingcard(bank: Int64, branchBank: String, cardNo: String, name:String, complete: CompleteBlock?, error: ErrorBlock?)
    //解绑银行卡
    func unbindcard( vToken :String,bid: Int32,timestamp: Int64, phone :String,vCode:String, complete: CompleteBlock?, error: ErrorBlock?)
    
    //充值列表
    func creditlist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //充值详情
    func creditdetail(rid: Int64, complete: CompleteBlock?, error: ErrorBlock?)
    // 结果查询
    func rechargeResults(rid: Int64, payResult: Int,complete: CompleteBlock?, error: ErrorBlock?)
    // 银联支付结果
    func unionpayResult(rid: Int64, payResult: Int,complete: CompleteBlock?, error: ErrorBlock?)
    // 微信充值
    func weixinpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?)
    // 银联充值
    func unionpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?)
    //银行卡提现
    func withdrawcash(money: Double, bld: Int64, password: String, complete: CompleteBlock?, error: ErrorBlock?)
    //提现列表
    func withdrawlist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //提现详情
    func withdrawdetail( withdrawld: Int64, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取银行卡名称
    func getBankName( withbankld: String, complete: CompleteBlock?, error: ErrorBlock?)
    //拉取用户信息
    func getUserinfo(complete: CompleteBlock?, error: ErrorBlock?)
    //请求修改个人信息
    func revisePersonDetail(screenName:String, avatarLarge: String, gender:Int64, complete: CompleteBlock?, error: ErrorBlock?)
    //修改用户昵称
    func resetUserScreenName(screenName:String, complete: CompleteBlock?, error: ErrorBlock?)

    //交易总概况
    func getTotalHistoryData(complete: CompleteBlock?, error: ErrorBlock?)
}
