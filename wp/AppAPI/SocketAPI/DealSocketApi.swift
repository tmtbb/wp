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
    
}
