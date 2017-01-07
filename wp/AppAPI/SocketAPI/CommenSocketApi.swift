//
//  CommenSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class CommenSocketApi: BaseSocketAPI, CommenApi {
    func imageToken(complete: CompleteBlock?, error: ErrorBlock?) {
        startRequest(SocketDataPacket.init(opcode: .imageToken), complete: complete, error: error)
    }
    //测试
    func test(complete: CompleteBlock?, error:ErrorBlock?){
       startModelRequest(SocketDataPacket.init(opcode: .test), modelClass: TestModel.self, complete: complete, error: error)
    }
}
