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
        let param = BaseParam()
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDeals, model: param, type:.time)
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
  
    //历史仓位列表
    func historyDeals(param: UndealParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDeals, model: param, type:.time)
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    //建仓
    func buildDeal(model: DealParam, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .buildDeal, model: model, type: .deal)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //商品列表
    func products(param: ProductParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .products, model: param, type: .deal)
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
    //仓位信息
    func position(param: PositionParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .position, model: param, type: .deal)
        startModelRequest(packet, modelClass: ProductPositionModel.self, complete: complete, error: error)
    }
    //收益选择
    func benifity(param: BenifityParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .benifity, model: param, type: .operate)
        startRequest(packet, complete: complete, error: error)
    }
    //明细列表
    func requestDealDetailList(pram:DealHistoryDetailParam, complete: CompleteBlock?, error:ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .historyDeals, model: pram, type: .time)
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
 
}






