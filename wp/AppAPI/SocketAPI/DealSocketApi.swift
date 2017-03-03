//
//  DealSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealSocketApi: BaseSocketAPI, DealApi {
   
    //当前仓位列表
    func currentDeals(complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.id ?? 32,
                                    SocketConst.Key.token: UserModel.share().token ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDeals, dict: param as [String : AnyObject], type:.time)
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //当前仓位详情
    func currentDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.id ?? 0,
                                    SocketConst.Key.token: UserModel.share().token ,
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位列表
    func historyDeals(start: Int,count: Int,complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.id ?? 32,
                                    SocketConst.Key.countNuber: count,
                                    SocketConst.Key.start: start,
                                    SocketConst.Key.token: UserModel.share().token]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDeals, dict: param as [String : AnyObject], type:.time)
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位详情
    func historyDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.id ?? 0,
                                    SocketConst.Key.token: UserModel.share().token ,
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //建仓
    internal func buildDeal(model: DealParam, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .buildDeal, model: model, type: .deal)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //平仓
    func sellOutDeal(complete: CompleteBlock?, error:ErrorBlock?){
//        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.id ?? 0,
//                                    SocketConst.Key.token: UserModel.share().token ,
//                                    SocketConst.Key.position: DealModel.share().selectDealModel?.positionId ?? 0]
//        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .sellOutDeal, dict: param as [String : AnyObject])
//        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //修改持仓
    func changeDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?){
//        model.token = UserModel.share().token 
//        model.id = UserModel.share().currentUser?.id ?? 0
//        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .changeDeal, model: model)
//        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //商品列表
    func products(pid:Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUserId,
                                    SocketConst.Key.token: UserModel.share().token,
                                    SocketConst.Key.pid: AppConst.pid]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .products, dict: param as [String : AnyObject], type: .deal)
        startModelsRequest(packet, listName: "goodsinfo", modelClass: ProductModel.self, complete: complete, error: error)
    }
    
    //当时K线数据
    func kChartsData(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .kChart, model: param, type: .time)
        startModelRequest(packet, modelClass: ChartModel.self, complete: complete, error: error)
    }
    
    //当时分时数据
    func timeline(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .timeline, model: param, type: .time)
        startModelsRequest(packet, listName: "priceinfo", modelClass: KChartModel.self, complete: complete, error: error)
    }
    
    //当前某个商品报价
    func realtime( param: [String: Any], complete: CompleteBlock?, error:ErrorBlock?) {
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .realtime, dict: param as [String : AnyObject], type: .time)
        startModelsRequest(packet, listName: "priceinfo", modelClass: KChartModel.self, complete: complete, error: error)
    }
    
 
}






