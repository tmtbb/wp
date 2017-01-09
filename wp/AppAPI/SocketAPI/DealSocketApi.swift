//
//  DealSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealSocketApi: BaseSocketAPI, DealApi {

    //获取分时接口
    func minDealInfo(type: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let packet = SocketDataPacket.init(opcode: .minDealInfo, dict: [SocketConst.Key.type : type as AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    
    //当前仓位列表
    func currentDeals(complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDeals, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //当前仓位详情
    func currentDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位列表
    func historyDeals(complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDeals, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位详情
    func historyDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //建仓
    func buildDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?){
        model.token = UserModel.token
        model.id = UserModel.share().currentUser?.uid ?? 0
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .buildDeal, model: model)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //平仓
    func sellOutDeal(positionId: Int, price: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId,
                                    SocketConst.Key.price: price]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .sellOutDeal, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //修改持仓
    func changeDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?){
        model.token = UserModel.token
        model.id = UserModel.share().currentUser?.uid ?? 0
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .changeDeal, model: model)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
}






