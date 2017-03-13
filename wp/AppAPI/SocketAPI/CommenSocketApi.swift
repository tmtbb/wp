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
        startRequest(SocketDataPacket.init(opcode: .imageToken, type:SocketConst.type.error), complete: complete, error: error)
    }
    
    func errorCode(complete: CompleteBlock?, error:ErrorBlock?){
        startRequest(SocketDataPacket.init(opcode: .errorCode), complete: complete, error: error)
    }
    
    //发送验证码
    func verifycode(verifyType: Int64, phone: String, complete: CompleteBlock?, error: ErrorBlock?){
//        let param = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
//                     SocketConst.Key.token: UserModel.share().token,
//                     SocketConst.Key.phone: phone,
//                     SocketConst.Key.verifyType: verifyType] as [String : Any]
        let param = [SocketConst.Key.phone: phone]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .verifycode, dict: param as [String : AnyObject] , type: SocketConst.type.wp)
        startRequest(packet, complete: complete, error: error)
    }
    func test(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd: pwd,
                                    SocketConst.Key.source: 1]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }
}
