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
    
    // 用户信息
    func accinfo(complete: CompleteBlock?, error: ErrorBlock?){
        let param = BaseParam()
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .accinfo, model: param, type: SocketConst.type.wp)
        startRequest(packet, complete: complete, error: error)
    }
    //银行卡列表
    func bankcardList(complete: CompleteBlock?, error: ErrorBlock?){
        
        let param = BaseParam()
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .bankcardList, model: param , type: SocketConst.type.drawcash)
        startModelRequest(packet, modelClass: BankModel.self, complete: complete, error: error)
    }
    
    //绑定银行卡(模型)
    func bingcard(param: BingCardParam , complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .bingcard, model: param, type: SocketConst.type.drawcash)
        startRequest(packet, complete: complete, error: error)
    }
    
    //解绑银行卡(模型)
    func unbindcard( param: UnBingCardParam, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .unbindcard, model: param, type: SocketConst.type.drawcash)
        startRequest(packet, complete: complete, error: error)
    }
    
    // 获取银行卡名称(模型)
    func getBankName( param: BankNameParam, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .getbankname, model: param, type: SocketConst.type.drawcash)
        startRequest(packet, complete: complete, error: error)
    }
    
    
    //充值列表(模型)
    func creditlist( param: BalanceListParam, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .rechageList, model: param, type: SocketConst.type.wp)
        startModelRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)
    }
    
    //充值详情(模型)
    func creditdetail(param: RechargeDetailParam, complete: CompleteBlock?, error: ErrorBlock?){

        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .recharge, model: param)
        startModelRequest(packet, modelClass: RechargeDetailModel.self, complete: complete, error: error)
    }
    
    
    //提现列表(模型)
    func withdrawlist( param: BalanceListParam, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .withdrawList, model: param, type: SocketConst.type.wp)
        startModelRequest(packet, modelClass: WithdrawListModel.self, complete: complete, error: error)
    }
    

    //提现详情(模型)
    func withdrawdetail(param: WithDrawDetailParam, complete: CompleteBlock?, error: ErrorBlock?){

        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .withdrawDetail, model: param )
        startModelRequest(packet, modelClass: WithdrawModel.self, complete: complete, error: error)
    }
    
    //交易总概况
    func getTotalHistoryData(complete: CompleteBlock?, error: ErrorBlock?) {
        let param = BaseParam()
        let packet = SocketDataPacket(opcode: .totalHistroy, model: param , type: .operate)
        startModelRequest(packet, modelClass: TotalHistoryModel.self, complete: complete, error: error)
    }
    
    // EasyPay充值
    func easypayRecharge(param: RechargeParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .easypayRecharge, model: param , type: .recharge)
        startModelRequest(packet, modelClass: RechargeResultModel.self, complete: complete, error: error)
    }
    // EasyPay提现
    func easypayWithDraw(param: WithDrawalParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .easypayWithDraw, model: param , type: .recharge)
        startModelRequest(packet, modelClass: WithdrawResultModel.self, complete: complete, error: error)
    }
}





