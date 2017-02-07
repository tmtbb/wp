//
//  BaseSocketAPI.swift
//  viossvc
//
//  Created by yaowang on 2016/11/23.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit

class BaseSocketAPI: NSObject {
    
    /**
     请求接口 数据解析成字典
     
     - parameter packet:   请求包
     - parameter complete: 成功回调 返回字典
     - parameter error:    失败回调
     */
    func startRequest(_ packet: SocketDataPacket, complete: CompleteBlock?, error: ErrorBlock?) {
        SocketRequestManage.shared.startJsonRequest(packet,complete: {  (response) in
            complete?((response as? SocketJsonResponse)?.responseJsonObject())
        },error: error)
    }
    

    /**
     请求接口 数据result_字段解析成int
     
     - parameter packet:   请求包
     - parameter complete: 成功回调 返回字典
     - parameter error:    失败回调
     */
    func startResultIntRequest(_ packet: SocketDataPacket, complete: @escaping CompleteBlock, error: ErrorBlock?) {
        SocketRequestManage.shared.startJsonRequest(packet,complete: {  (response) in
            complete((response as? SocketJsonResponse)?.responseResult() as AnyObject?)
        },error: error)
    }
    
    /**
     请求接口 数据解析成model实体
     
     - parameter packet:     请求包
     - parameter modelClass: 要解析填充的model类class
     - parameter complete:   成功回调 返回modelClass的model实体
     - parameter error:      失败回调
     */
    func startModelRequest(_ packet: SocketDataPacket, modelClass: AnyClass, complete: CompleteBlock?, error: ErrorBlock?) {
        
       
        SocketRequestManage.shared.startJsonRequest(packet, complete: {  (response) in
            complete?((response as? SocketJsonResponse)?.responseModel(modelClass))
            
            }, error: error)
    }
    
    /**
     请求接口 数据解析成model实体数组
     
     - parameter packet:     请求包
     - parameter modelClass: 要解析填充的model类class
     - parameter complete:   成功回调 返回modelClass的model实体数组
     - parameter error:      失败回调
     */
    func startModelsRequest(_ packet: SocketDataPacket, modelClass: AnyClass, complete: CompleteBlock?, error: ErrorBlock?) {
        SocketRequestManage.shared.startJsonRequest(packet, complete: {  (response) in
            complete?((response as? SocketJsonResponse)?.responseModels(modelClass) as AnyObject?)
            }, error: error)
    }
    
    /**
     请求接口 数据data_list_字段解析成model实体数组
     
     - parameter packet:     请求包
     - parameter modelClass: 要解析填充的model类class
     - parameter complete:   成功回调 返回modelClass的model实体数组
     - parameter error:      失败回调
     */
    func startDataListRequest(_ packet: SocketDataPacket, modelClass: AnyClass, complete: CompleteBlock?, error: ErrorBlock?) {
        
       startModelsRequest(packet, listName:"data_list_", modelClass: modelClass, complete: complete, error: error)
    }
    
    /**
     请求接口 数据listName字段解析成model实体数组
     
     - parameter packet:     请求包
     - parameter listName:   列表字段名
     - parameter modelClass: 要解析填充的model类class
     - parameter complete:   成功回调 返回modelClass的model实体数组
     - parameter error:       失败回调
     */
    func startModelsRequest(_ packet: SocketDataPacket, listName:String, modelClass: AnyClass, complete: CompleteBlock?, error: ErrorBlock?) {
        SocketRequestManage.shared.startJsonRequest(packet, complete: {  (response) in
            let dict:[String:AnyObject]? = ((response as? SocketJsonResponse)?.responseJsonObject()) as? [String:AnyObject]
            if dict != nil {
                let array:[Any]? = dict?[listName] as? [Any]
                if array != nil  {
                    complete?(try! OEZJsonModelAdapter.models(of: modelClass, fromJSONArray: array) as AnyObject?)
                }
            }
            return nil
        }, error: error)
    }

}
