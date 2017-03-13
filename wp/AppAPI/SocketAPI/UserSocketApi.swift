//
//  UserSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class UserSocketApi: BaseSocketAPI, UserApi {
    
    //设置用户信息
    func userInfo(user: UserInfo, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid : UserModel.share().currentUserId]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .userInfo, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    
    //流水列表
    func flowList(flowType: String, startPos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.flowType: flowType,
                     SocketConst.Key.startPos: startPos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .flowList, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "orders", modelClass: FlowOrdersList.self, complete: complete, error: error)
    }
    //流水详情
    func flowDetails(flowld: Int64, flowType: Int8, complete: CompleteBlock?, error: ErrorBlock?){
         
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.flowld: flowld,
                     SocketConst.Key.flowType: flowType] as [String : Any]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .flowDetails, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: FlowDetails.self, complete: complete, error: error)
        
    }
    // 用户信息
    func accinfo(complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ] as [String : Any]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .accinfo, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    //银行卡列表
    func bankcardList(complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ] as [String : Any]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .bankcardList, dict: param as [String : AnyObject], type: SocketConst.type.user)
        startModelRequest(packet, modelClass: BankModel.self, complete: complete, error: error)
        print(param)
        //        startModelsRequest(packet, listName: "cardlist", modelClass: BankModel.self, complete: complete, error: error)
        
    }
    //绑定银行卡
    func bingcard(bank: Int64, branchBank: String, cardNo: String, name:String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.bankId: bank,
                     SocketConst.Key.branchBank: branchBank,
                     SocketConst.Key.cardNo:cardNo,
                     SocketConst.Key.name: name] as [String : Any]
        
        print(param)
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .bingcard, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        
        startRequest(packet, complete: complete, error: error)
        
    }
    // 获取银行卡名称
    func getBankName( withbankld: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUserId ,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.cardNo: withbankld]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .getbankname, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        
        startRequest(packet, complete: complete, error: error)
        
    }
    //解绑银行卡
        func unbindcard( vToken :String,bid: Int32,timestamp: Int64, phone :String,vCode:String, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.bankId: bid,
                     SocketConst.Key.phone: phone,
                     SocketConst.Key.code: vCode,
                     SocketConst.Key.timestamp: timestamp,
                     SocketConst.Key.vToken: "3021",
                    ] as [String : Any]
        print(param)
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .unbindcard, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        startRequest(packet, complete: complete, error: error)
    }
    //充值列表
    func creditlist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .rechageList, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startModelRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)
        
    }
    //充值详情
    func creditdetail(rid: Int64, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUserId,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.rid: rid]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .recharge, dict: param as [String : AnyObject])
        
        
        startModelRequest(packet, modelClass: RechargeDetailModel.self, complete: complete, error: error)
    }
    //银行卡提现
    func withdrawcash(money: Double, bld: Int64, password: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUserId,
                                     SocketConst.Key.token:  UserModel.share().token ,
                                     SocketConst.Key.price: money,
                                     SocketConst.Key.bankId: bld,
                                     SocketConst.Key.comment: "五",
                                     SocketConst.Key.password: password]
        
        //        print(param)
        //        WithdrawBankCashModel
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .withdrawCash, dict: param as [String : AnyObject], type: SocketConst.type.operate)
        
            startModelRequest(packet, modelClass: WithdrawModel.self, complete: complete, error: error)
//               startRequest(packet, complete: complete, error: error)
    }
    //提现列表
    func withdrawlist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .withdrawList, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        startModelRequest(packet, modelClass: WithdrawListModel.self, complete: complete, error: error)
    }
    //提现详情
    func withdrawdetail(withdrawld: Int64, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUserId ,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.wid: withdrawld]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .withdrawDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: WithdrawModel.self, complete: complete, error: error)
    }
    // 微信支付
    func weixinpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.title: title,SocketConst.Key.price: price]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .weixinpay, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    // 银联支付
    func unionpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 33,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.title: title,SocketConst.Key.price: price]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .unionpay, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    // 结果查询
    func rechargeResults(rid: Int64, payResult: Int,complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.payResult: payResult,SocketConst.Key.rid: rid]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .payResult, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    // 银联结果查询
    func unionpayResult(rid: Int64, payResult: Int,complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 32,
                                     SocketConst.Key.token: UserModel.share().token ,
                                     SocketConst.Key.payResult: payResult,SocketConst.Key.rid: rid]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .unionpayResult, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    //拉取用户信息
    func getUserinfo(complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uidStr: "\(UserModel.share().currentUserId)"] as [String : Any]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .getUserinfo, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        startModelsRequest(packet, listName: "userinfoList", modelClass: UserInfo.self, complete: complete, error: error)
    
    }
    
    //请求修改个人信息
    func revisePersonDetail(screenName:String, avatarLarge: String, gender:Int64 = 0, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.screenName: screenName,
                     SocketConst.Key.avatarLarge: avatarLarge,
                     SocketConst.Key.gender: gender] as [String : Any]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .changeUserInfo, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        startRequest(packet, complete: complete, error: error)

    }
    
    //修改用户昵称
    func resetUserScreenName(screenName:String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                     SocketConst.Key.screenName: screenName] as [String : Any]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .changeUserInfo, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        startRequest(packet, complete: complete, error: error)
    }
    func everyday(start: Int32,count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currentUserId,
                     SocketConst.Key.token: UserModel.share().token ,
                     SocketConst.Key.start: start,
                     SocketConst.Key.countNuber: count,] as [String : Any]
//          let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .everyday, dict: param as [String : AnyObject], type: SocketConst.type.operate)
//        startRequest(packet, complete: complete, error: error)
    }
    

    //交易总概况
    func getTotalHistoryData(complete: CompleteBlock?, error: ErrorBlock?) {
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().currentUserId,
                                     SocketConst.Key.token: UserModel.share().token]
        
        let packet = SocketDataPacket(opcode: .totalHistroy, dict: param as [String : AnyObject], type: .operate)
        
        startModelRequest(packet, modelClass: TotalHistoryModel.self, complete: complete, error: error)
    }
}





