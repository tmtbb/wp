//
//  ShareSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class ShareSocketApi: BaseSocketAPI, ShareApi {
    /**我的晒单网络请求**/
    func ShareSortData(userId: String, phone: String, selectIndex: String, pageNumber: String, complete: CompleteBlock?, error: ErrorBlock?) {
        
    }
    
    
    // 我的晒单网络请求
    func getShareData(userId : String, phone: String,selectIndex: String,pageNumber: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().currentUser?.id  ?? 0,
                                    SocketConst.Key.pwd: userId,
                                    SocketConst.Key.code: phone]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .userShare, dict: param as [String : AnyObject])
        
        startModelsRequest(packet, listName: "depositsinfo", modelClass: RechargeDetailModel.self, complete: complete, error: error)
    }
    
}
