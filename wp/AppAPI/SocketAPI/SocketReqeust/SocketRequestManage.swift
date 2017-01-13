//
//  SocketPacketManage.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
//import XCGLogger

class SocketRequestManage: NSObject {
    
    static let shared = SocketRequestManage();
    fileprivate var socketRequests = [UInt32: SocketRequest]()
    fileprivate var _timer: Timer?
    fileprivate var _lastHeardBeatTime:TimeInterval!
    fileprivate var _lastConnectedTime:TimeInterval!
    fileprivate var _reqeustId:UInt32 = 10000
    fileprivate var _socketHelper:SocketHelper?
    fileprivate var _sessionId:UInt64 = 0
    var receiveChatMsgBlock:CompleteBlock?
    var operate_code = 0
    func start() {
        _lastHeardBeatTime = timeNow()
        _lastConnectedTime = timeNow()
        stop()
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didActionTimer), userInfo: nil, repeats: true)
#if true
        _socketHelper = APISocketHelper()
#else
        _socketHelper = LocalSocketHelper()
#endif
        
        _socketHelper?.connect()
    }
    
    func stop() {
        _timer?.invalidate()
        _timer = nil
        objc_sync_enter(self)
        _socketHelper?.disconnect()
        _socketHelper = nil
        objc_sync_exit(self)
    }
    
    var reqeustId:UInt32 {
        get {
            objc_sync_enter(self)
            if _reqeustId > 2000000000 {
                _reqeustId = 10000
            }
            _reqeustId += 1
            objc_sync_exit(self)
            return _reqeustId;
        }
        
    }

    func notifyResponsePacket(_ packet: SocketDataPacket) {
        
        objc_sync_enter(self)
        _sessionId = packet.session_id
        let socketReqeust = socketRequests[UInt32(packet.session_id)]
        socketRequests.removeValue(forKey: UInt32(packet.session_id))
        objc_sync_exit(self)
        let response:SocketJsonResponse = SocketJsonResponse(packet:packet)
        let statusCode:Int = response.statusCode;
        if ( statusCode < 0) {
            socketReqeust?.onError(statusCode)
        } else {
            socketReqeust?.onComplete(response)
        }
        
    }
    
    
    func checkReqeustTimeout() {
        objc_sync_enter(self)
        for (key,reqeust) in socketRequests {
            if reqeust.isReqeustTimeout() {
                socketRequests.removeValue(forKey: key)
                reqeust.onError(-11011)
                break
            }
        }
        objc_sync_exit(self)
    }
    
    
    fileprivate func sendRequest(_ packet: SocketDataPacket) {
        let block:()->() = {
            [weak self] in
            self?._socketHelper?.sendData(packet.serializableData()!)
        }
        objc_sync_enter(self)
        if _socketHelper == nil {
            SocketRequestManage.shared.start()
            let when = DispatchTime.now() + Double((Int64)(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: when,execute: block)
        }
        else {
            block()
        }
        objc_sync_exit(self)
    }
    
    func startJsonRequest(_ packet: SocketDataPacket, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let socketReqeust = SocketRequest();
        socketReqeust.error = error;
        socketReqeust.complete = complete;
        packet.request_id = reqeustId;
        packet.session_id = _sessionId;
        operate_code = Int(packet.operate_code)
        objc_sync_enter(self)
        socketRequests[UInt32(packet.session_id)] = socketReqeust;
        objc_sync_exit(self)
        sendRequest(packet)
    }
    
    func sendChatMsg(_ packet: SocketDataPacket,complete:CompleteBlock,error:ErrorBlock) {
        packet.request_id = reqeustId;
        packet.session_id = _sessionId;
        sendRequest(packet)
    }
    
    fileprivate func timeNow() ->TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    fileprivate func lastTimeNow(_ last:TimeInterval) ->TimeInterval {
        return timeNow() - last
    }
    
    fileprivate func isDispatchInterval(_ lastTime:inout TimeInterval,interval:TimeInterval) ->Bool {
        if timeNow() - lastTime >= interval  {
            lastTime = timeNow()
            return true
        }
        return false
    }
    
    
    fileprivate func sendHeart() {
        let packet = SocketDataPacket(opcode: .heart,dict:[SocketConst.Key.uid: 0 as AnyObject])
        sendRequest(packet)
    }
    
    func didActionTimer() {
        if _socketHelper != nil && _socketHelper!.isConnected {
            
            _lastConnectedTime = timeNow()
        }
        else if( isDispatchInterval(&_lastConnectedTime!,interval: 10) ) {
            _socketHelper?.connect()
        }
        checkReqeustTimeout()
    }

}
