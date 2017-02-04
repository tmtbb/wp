//
//  UITableView+Extension.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
extension UITableView {
    func registerNib<T:UITableViewCell>(_ type:T.Type ,forCellReuseIdentifier identifier: String?) {
        var cellIdentifie = identifier;
        if cellIdentifie == nil {
            cellIdentifie = type.className();
        }
        register(UINib(nibName:T.className(),bundle: nil), forCellReuseIdentifier: cellIdentifie!);
    }
    
    func registerNib<T:UITableViewCell>(_ type:T.Type) {
        registerNib(type, forCellReuseIdentifier:T.className());
    }
    
    func registerClass<T:UITableViewCell>(_ type:T.Type) {
         register(type, forCellReuseIdentifier: type.className());
    }
}
