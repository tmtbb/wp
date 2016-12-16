//
//  UIFont+Extension.swift
//  viossvc
//
//  Created by abx’s mac on 2016/12/2.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

extension UIFont {
    
  static  func SIZE(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    

 static   func HEIGHT(_ fontSize : CGFloat) -> CGFloat {
      return   UIFont.systemFont(ofSize: fontSize).lineHeight
    }
    
    
}
