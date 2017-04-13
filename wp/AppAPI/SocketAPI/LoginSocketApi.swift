//
//  LoginSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class LoginSocketApi: BaseSocketAPI, LoginApi { 
    //登录(模型)
    func login(param: LoginParam, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, model: param)
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }
 
    //token登录(模型)
    func tokenLogin(param: ChecktokenParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .tokenLogin, model: param, type:.user)
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }
    
    //注册（模型）
    func register(model:RegisterParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    //重置密码(模型)
    func repwd(param: ResetPwdParam, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .repwd, model: param)
        startRequest(packet, complete: complete, error: error)
    }
}
