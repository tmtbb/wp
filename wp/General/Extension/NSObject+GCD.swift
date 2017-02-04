//
//  NSObject+GCD.swift
//  wp
//
//  Created by 木柳 on 2017/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation

typealias Task = (_ cancel: Bool) -> Void
extension NSObject{
    
    func delay(_ time: TimeInterval, task: @escaping()->()) -> Task? {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+time) {
            task()
        }
        return nil
        func dispatch_late(block: @escaping ()->()){
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure:(()->Void)? = task
        var result: Task?
        
        let delayedClosure: Task = { cancel in
            if let internalClosure = closure {
                if cancel == false {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayedClosure
        
        dispatch_late {
            if let delayedClosure = result{
                delayedClosure(false)
            }
        }
        return result
    }
    
   
    func cancel(_ task: Task?) {
        task?(true)
    }
    

}
