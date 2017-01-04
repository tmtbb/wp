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
    //账户信息
    func accountNews(id: Int64, token: String, complete: CompleteBlock?, error: ErrorBlock?)
    //流水列表
    func flowList(id: Int64, token: String, flowType: String, startPos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //流水详情
    func flowDetails(id: Int64, token: String, flowld: Int64, flowType: Int8, complete: CompleteBlock?, error: ErrorBlock?)
    //银行卡列表
    func bankcardList(id: Int64, token: String,complete: CompleteBlock?, error: ErrorBlock?)
    //绑定银行卡
    func bingcard(id: Int64, token: String, bank: String, branchBank: String, province: String, city: String, cardNo: String, name:String, complete: CompleteBlock?, error: ErrorBlock?)
    //解绑银行卡
    func unbindcard(id: Int64, token: String, bankId: Int32, vCode:Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //充值列表
    func creditlist(id: Int64, token: String, status: String, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //充值详情
    func creditdetail(id: Int64, token: String, rid: Int64, complete: CompleteBlock?, error: ErrorBlock?)
    //银行卡提现
    func withdrawcash(id: Int64, token: String, money: Double, bld: Int64, password: String, complete: CompleteBlock?, error: ErrorBlock?)
    //提现列表
    func withdrawlist(id: Int64, token: String, status: String, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
    //提现详情
    func withdrawdetail(id: Int64, token: String, withdrawld: Int64, complete: CompleteBlock?, error: ErrorBlock?)
}
