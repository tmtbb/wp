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
}
