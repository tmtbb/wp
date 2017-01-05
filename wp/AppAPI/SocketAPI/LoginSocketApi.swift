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
                                    SocketConst.Key.pwd: pwd.sha256(),
                                    SocketConst.Key.source: 1]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: UserInfo.self, complete: complete, error: error)
    }
    //注册
    func register(phone: String, code: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.phone: phone,
                                     SocketConst.Key.code: code,
                                     SocketConst.Key.pwd: pwd,
                                     SocketConst.Key.memberId: 0,
                                     SocketConst.Key.agentId: "",
                                     SocketConst.Key.recommend: ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //重置密码
    func repwd( pwd: String, code: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id ?? 0,
                                    SocketConst.Key.pwd: pwd,
                                    SocketConst.Key.code: code]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .repwd, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //获取声音验证码
    func voiceCode(phone: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.phone: phone]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .voiceCode, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }

}
