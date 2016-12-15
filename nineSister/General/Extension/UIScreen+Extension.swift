//
//  UIScreen+Extension.swift
//  viossvc
//
//  Created by yaowang on 2016/11/1.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
extension UIScreen {
    class func width() ->CGFloat {
       return  UIScreen.main.bounds.width;
    }
    class func height() ->CGFloat {
        return  UIScreen.main.bounds.height;
    }
}
