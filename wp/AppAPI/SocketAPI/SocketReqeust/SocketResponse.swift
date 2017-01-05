//
//  SocketResponse.swift
//  viossvc
//
//  Created by yaowang on 2016/11/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class SocketResponse {
    fileprivate var body:SocketDataPacket?
    var statusCode:UInt16? {
        get {
            return body?.operate_code
        }
    }
    
    func responseData() -> Data? {
        return body?.data as Data?
    }
    
    init(packet:SocketDataPacket) {
        body = packet;
    }
}

class SocketJsonResponse: SocketResponse {
    
    func responseJsonObject() -> AnyObject? {
        if body?.data?.count == 0  {
            return nil
        }
        
        return try! JSONSerialization.jsonObject(with: body!.data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject?
    }
    
    func responseJson<T:NSObject>() ->T? {
        var object = responseJsonObject()
        if object != nil && T.isKind(of: NSObject.self) {
            object = responseModel(T.classForCoder())
        }
        return object as? T
    }
    
    func responseModel(_ modelClass: AnyClass) ->AnyObject?{
        let object = responseJsonObject()
        if object != nil  {
            return try! OEZJsonModelAdapter.model(of: modelClass, fromJSONDictionary: object as! [AnyHashable: Any]) as AnyObject?
        }
        return nil
    }
    
    func responseModels(_ modelClass: AnyClass) ->[AnyObject]? {
        
        let array:[AnyObject]? = responseJsonObject() as? [AnyObject]
        if array != nil {
            return try! OEZJsonModelAdapter.models(of: modelClass, fromJSONArray: nil) as [AnyObject]?
        }
        return nil;
    }
    
    func responseResult() -> Int? {
        let dict = responseJsonObject() as? [String:AnyObject]
        if dict != nil && dict!["result_"] != nil {
            return dict!["result_"] as? Int;
        }
        return nil;
    }
    
}

