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
    var statusCode:Int {
        get {
            return Int(body!.operate_code)
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
    private var _jsonOjbect:AnyObject?;
    
    override var statusCode: Int {
        get{
            let dict:NSDictionary? = responseJsonObject() as? NSDictionary
            var errorCode: Int = 0;
            if ( dict == nil ) {
                errorCode = -11012; //json解析失败
            }
            else if(  dict != nil && dict?["errorCode"] != nil ) {
                errorCode =  dict?["errorCode"] as! Int;
            }
            else {
                errorCode = 0;
            }
            return errorCode;
        }
    }
    func responseJsonObject() -> AnyObject? {
        if body?.data?.count == 0  {
            return nil
        }
        
        if _jsonOjbect == nil  {
            
            do{
                #if false
                 var json = String(data: body!.data!, encoding: .utf8)
                json = json == nil ? "" : json;
//                debugPrint("\(body!.operate_code) \(body!.data_length) json\(json!)")
                #endif
                
                _jsonOjbect = try JSONSerialization.jsonObject(with: body!.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject?
            }catch let error as Error! {
                var json = String(data: body!.data!, encoding: .utf8)
                json = json == nil ? "" : json;
                 debugPrint("解析json\(json!) \(error) ")
            }
        }
        return _jsonOjbect
    }
    
    func responseJson<T:NSObject>() ->T? {
        var object = responseJsonObject()
        if object != nil && !(T.isKind(of: NSDictionary.self)) && T.isKind(of: NSObject.self) {
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

