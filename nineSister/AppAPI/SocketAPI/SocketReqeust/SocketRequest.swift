//
//  SocketRequest.swift
//  viossvc
//
//  Created by yaowang on 2016/11/23.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
//import XCGLogger


class SocketRequest {
    
    static var errorDict:NSDictionary?;
    var error: ErrorBlock?
    var complete: CompleteBlock?
    var timestamp: TimeInterval = Date().timeIntervalSince1970
    
    class func errorString(_ code:Int) ->String {
        if errorDict == nil {
            if let bundlePath = Bundle.main.path(forResource: "errorcode", ofType: "plist") {
                errorDict = NSDictionary(contentsOfFile: bundlePath)
            }
        }
        let key:String = String(format: "%d", code);
        if errorDict?.object(forKey: key) != nil {
            return errorDict!.object(forKey: key) as! String
        }
        return "Unknown";
    }

    
    deinit {
        
//        XCGLogger.debug(" \(self)")
        
    }
    
    
    func isReqeustTimeout() -> Bool {
       return  timestamp + Double(AppConst.Network.TimeoutSec)  <= Date().timeIntervalSince1970
    }
    
    
    fileprivate func dispatch_main_async(_ block:@escaping ()->()) {
        DispatchQueue.main.async(execute: {
            block()
        })
    }
    
    
    func onComplete(_ obj:AnyObject!) {
        dispatch_main_async { 
            self.complete?(obj)
        }
    }
    
    
    func onError(_ errorCode:Int!) {
        let errorStr:String = SocketRequest.errorString(errorCode)
        let error = NSError(domain: AppConst.Text.ErrorDomain, code: errorCode
            , userInfo: [NSLocalizedDescriptionKey:errorStr]);
        onError(error)
    }
    
    func onError(_ error:NSError!) {
        dispatch_main_async {
            self.error?(error)
        }
    }
    
}
