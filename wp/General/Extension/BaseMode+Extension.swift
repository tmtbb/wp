//
//  BaseMode+Extension.swift
//  wp
//
//  Created by 木柳 on 2017/1/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation

extension NSObject{
    
    func convertToTargetObject(_ object: AnyObject)  {
        let r = Mirror.init(reflecting: object)
        for rChild in r.children {
            let value = valueFrom(self, key: rChild.label!)
            if !(value is NSNull) && value != nil {
                object.setValue(value, forKey: rChild.label!)
            }
        }
    }
    
    func valueFrom(_ object: Any, key: String) -> Any? {
        let mirror = Mirror.init(reflecting: object)
        for child in mirror.children {
            if child.label == key {
                return child.value
            }
        }
        return nil
    }
}
