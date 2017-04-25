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
    func userInfo(user: UserInfo, complete: CompleteBlock?, error: ErrorBlock?)    //流水详情
    //账户信息
    func accinfo(complete: CompleteBlock?, error: ErrorBlock?)
    //银行卡列表
    func bankcardList(complete: CompleteBlock?, error: ErrorBlock?)
    //绑定银行卡(模型)
    func bingcard(param: BingCardParam , complete: CompleteBlock?, error: ErrorBlock?)
    //解绑银行卡(模型)
    func unbindcard( param: UnBingCardParam, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取银行卡名称(模型)
    func getBankName( param: BankNameParam, complete: CompleteBlock?, error: ErrorBlock?)
    //充值列表(模型)
    func creditlist( param: BalanceListParam, complete: CompleteBlock?, error: ErrorBlock?)
    //充值详情(模型)
    func creditdetail(param: RechargeDetailParam, complete: CompleteBlock?, error: ErrorBlock?)
    //充值列表(模型)
    func withdrawlist( param: BalanceListParam, complete: CompleteBlock?, error: ErrorBlock?)
    //提现详情(模型)
    func withdrawdetail(param: WithDrawDetailParam, complete: CompleteBlock?, error: ErrorBlock?)
    //交易总概况
    func getTotalHistoryData(complete: CompleteBlock?, error: ErrorBlock?)
    // EasyPay充值
    func easypayRecharge(param: RechargeParam, complete: CompleteBlock?, error: ErrorBlock?)
    // EasyPay提现
    func easypayWithDraw(param: WithDrawalParam, complete: CompleteBlock?, error: ErrorBlock?)
}
