//
//  SocketHelper.swift
//  wp
//
//  Created by yaowang on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation
protocol SocketHelper {
    var isConnected : Bool {  get }
    func connect()
    func disconnect()
    func sendData(_ data: Data)
}
