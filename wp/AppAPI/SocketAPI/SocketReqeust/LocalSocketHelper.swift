//
//  LocalSocketHelper.swift
//  wp
//
//  Created by yaowang on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class LocalSocketHelper: NSObject , SocketHelper {
    
    static var testsocketDict:NSDictionary?;
    
    class func socketData(_ code:Int) ->Data? {
        if testsocketDict == nil {
            if let bundlePath = Bundle.main.path(forResource: "testsocket", ofType: "plist") {
                testsocketDict = NSDictionary(contentsOfFile: bundlePath)
            }
        }
        let key:String = String(format: "%d", code)
        if testsocketDict?.object(forKey: key) != nil {
            let json:String = testsocketDict!.object(forKey: key) as! String
            return json.data(using: .utf8)!
        }
        return nil
    }
    
    var isConnected : Bool
    {
        return true
    }
    
    func connect() {
        
    }
    
    func disconnect() {
        
    }
    
    func sendData(_ data: Data) {
        let packet: SocketDataPacket = SocketDataPacket(socketData: data as NSData)
        if let data = LocalSocketHelper.socketData(Int(packet.operate_code)) {
            packet.data = data
            packet.data_length = UInt16(data.count)
            SocketRequestManage.shared.notifyResponsePacket(packet)
        }
    }
}
