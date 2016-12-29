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
        let param = [SocketConst.Key.phone: phone,
                     SocketConst.Key.pwd: pwd]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //注册
    func register(phone: String, code: String, voiceCode: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.phone: phone,
                     SocketConst.Key.code: code,
                     SocketConst.Key.voiceCode: voiceCode]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }
    //重置密码
    func repwd(uid: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().currenUser?.uId ?? 0,
                     SocketConst.Key.pwd: pwd] as [String : Any]
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
