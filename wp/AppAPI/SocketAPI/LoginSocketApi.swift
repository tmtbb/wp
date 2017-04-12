//
//  LoginSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class LoginSocketApi: BaseSocketAPI, LoginApi {
    //登录
    func login(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd: pwd,
                                    SocketConst.Key.source: 1]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }
    //token登录
    func tokenLogin(uid: Int, token: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.uid: uid,
                                    SocketConst.Key.token: token,
                                    SocketConst.Key.source: 1]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .tokenLogin, dict: param as [String : AnyObject], type:.user)
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }
    //注册（模型）
    func register(model:RegisterParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    //重置密码
    func repwd(phone: String, type: Int, pwd: String, code: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd: pwd,
                                    SocketConst.Key.code: code,
                                    SocketConst.Key.type: type,
                                    SocketConst.Key.timestamp: UserModel.share().timestamp,
                                    SocketConst.Key.vToken: UserModel.share().codeToken,
                                    SocketConst.Key.uid: UserModel.share().currentUserId]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .repwd, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
}
