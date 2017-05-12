//
//  HomeParam.swift
//  wp
//
//  Created by mu on 2017/4/22.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation


class RechargeParam: BaseParam{
    var merchantNo = ""
    var currency = "CNY"
    var amount: Double = 0
    var content = ""
    var payType = "WECHAT_JSAPI_PAY"//"H5_ONLINE_BANK_PAY"
    var wechatOpenId = ""
    var wechatAppId = "wx9dc39aec13ee3158"
}

class WithDrawalParam: BaseParam{
    var merchantNo = ""
    var amount: Double = 0
    var bid = 0
    var content = ""
    var receiverBankName = ""
    var receiverBranchBankName = ""
    var receiverBranchBankCode = ""
    var receiverCardNo = ""
    var receiverAccountName = ""
}

class BingCardParam: BaseParam{
    var bankId = 0
    var branchBank = ""
    var bankName = ""
    var cardNO = ""
    var name = ""
}

class UnBingCardParam: BaseParam{
    var bankCardId = 0
    var verCode = ""
}

class BankNameParam: BaseParam{
    var cardNo = ""
}

class BalanceListParam: BaseParam {
    var status = 0
    var start = 0
    var count = 0
    var startPos = 0
}

class RechargeDetailParam: BaseParam{
    var rid = 0
}

class WithDrawDetailParam: BaseParam{
    var wid = ""
}

class UpdateParam: BaseParam{
    var appName = ""
    var newAppSize = 0
    var newAppVersionCode: Double = 0
    var newAppVersionName = ""
    var newAppUpdateDesc = ""
    var newAppReleaseTime = ""
    var newAppUrl = ""
    var isForceUpdate = 0
    var haveUpate = false
}
