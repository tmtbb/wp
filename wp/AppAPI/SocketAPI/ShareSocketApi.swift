//
//  ShareSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class ShareSocketApi: BaseSocketAPI, ShareApi {
    
    //
    func getData(userId : String, phone: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().currenUser?.uId ?? 0,
                                    SocketConst.Key.pwd: userId,
                                    SocketConst.Key.code: phone]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .repwd, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)
    }

}
