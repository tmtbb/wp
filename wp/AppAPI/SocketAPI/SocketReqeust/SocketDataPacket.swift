 //
//  SocketDataPacket.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
//import XCGLogger
class SocketDataPacket {
    
    var packetHead:SocketPacketHead = SocketPacketHead();
    var data: Data?
    fileprivate static var packet_id:UInt32 = 10000;
    var packet_length:UInt16 {
        get { return packetHead.packet_length }
        set { packetHead.packet_length = newValue }
    }
    var is_zip_encrypt:UInt8  {
        get { return packetHead.is_zip_encrypt }
        set { packetHead.is_zip_encrypt = newValue }
    }

    var type:UInt8 {
        get { return packetHead.type }
        set { packetHead.type = newValue }
    }
    var signature:UInt16 {
        get { return packetHead.signature }
        set { packetHead.signature = newValue }
    }

    var operate_code:UInt16 {
        get { return packetHead.operate_code }
        set { packetHead.operate_code = newValue }
    }

    var data_length:UInt16 {
        get { return packetHead.data_length }
        set { packetHead.data_length = newValue }
    }


    var timestamp:UInt32 {
        get { return packetHead.timestamp }
        set { packetHead.timestamp = newValue }
    }


    var session_id:UInt64 {
        get { return packetHead.session_id }
        set { packetHead.session_id = newValue }
    }

    var request_id:UInt32 {
        get { return packetHead.request_id }
        set { packetHead.request_id = newValue }
    }



    init() {
        memset(&self.packetHead,0, MemoryLayout<SocketPacketHead>.size)
    }
    convenience init(opcode: SocketConst.OPCode,type: SocketConst.type = .user) {
        self.init(opcode: opcode,data:nil,type: type);
    }
    convenience init(opcode: SocketConst.OPCode, data: Data?,type: SocketConst.type = .user) {
        self.init();
        self.type = type.rawValue
        self.operate_code = opcode.rawValue
        self.data = data
        self.data_length = data == nil ? 0 : UInt16(data!.count)
        self.packet_length = self.data_length + 0x1a
        self.timestamp = UInt32(Date().timeIntervalSince1970)
    }

    convenience init( opcode: SocketConst.OPCode, strData: String,type: SocketConst.type = .user) {
        let data: Data! = strData.data(using: String.Encoding.utf8)
        self.init( opcode: opcode, data: data,type: type)
    }

    convenience init(opcode: SocketConst.OPCode, model: BaseModel,type: SocketConst.type = .user) {
        let strData: String = model.description
        self.init( opcode: opcode, strData: strData,type:type)
    }
    
    convenience init(opcode: SocketConst.OPCode, dict:[String : AnyObject],type: SocketConst.type = .user) {
        let data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        self.init( opcode: opcode, data: data,type: type)
    }
    
    init(socketData: NSData) {
        memset(&packetHead,0, MemoryLayout<SocketPacketHead>.size)
        socketData.getBytes(&packetHead, length: MemoryLayout<SocketPacketHead>.size)
        if( Int(packet_length ) - MemoryLayout<SocketPacketHead>.size == Int(data_length)) {
            var range:NSRange = NSMakeRange(0,Int(data_length))
            range.location = Int(packet_length - data_length)
            self.data = socketData.subdata(with: range)
        }
        else {
            debugPrint("onPacketData error packet_length:\(packet_length) packet_length:\(data_length) data:\(socketData.length)");
        }
    
    }
    

    func serializableData() -> Data? {
        let outdata: NSMutableData = NSMutableData()
//        self.data_length = data == nil ? 0 : UInt16(data!.length)
//        self.packet_length = self.data_length + 0x1a
//        self.timestamp = UInt32(NSDate().timeIntervalSince1970)
        outdata.append(&self.packetHead, length: MemoryLayout<SocketPacketHead>.size);
        if self.data != nil {
            outdata.append(self.data!)
        }
        return outdata as Data;
    }
    
//    deinit {
//            XCGLogger.debug("deinit \(self)")
//    }
}
