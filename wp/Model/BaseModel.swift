//
//  BaseModel.swift
//  viossvc
//
//  Created by yaowang on 2016/11/21.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
//import XCGLogger
class BaseModel: OEZModel {
    override class func jsonKeyPostfix(_ name: String!) -> String! {
        return "";
    }
    deinit {
        
    }
}


class BaseDBModel: BaseModel {
    var id:Int = 0
    
    
    func primaryKeyValue() ->AnyObject! {
        return id as AnyObject!
    }
    
    class func tableName() ->String {
        return self.className()
    }
    
}
