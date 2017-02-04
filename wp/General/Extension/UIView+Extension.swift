//
//  UIView+Extension.swift
//  wp
//
//  Created by 木柳 on 2016/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

extension UIView{
    
//    open override static func initialize() {
//        let originalSelector = #selector(setter: backgroundColor)
//        let swizzledSelector = #selector(hook_setBackgroundColor(color:))
//        
//        let originalMethod = class_getInstanceMethod(self, originalSelector)
//        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//        
//        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//        
//        if didAddMethod {
//            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    }
//    
//    func hook_setBackgroundColor(color: UIColor) {
//        hook_setBackgroundColor(color: color)
//        print("============================")
//    }
}
