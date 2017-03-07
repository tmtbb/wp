//
//  CommenApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol CommenApi {
    //获取上传图片token
    func imageToken(complete: CompleteBlock?, error:ErrorBlock?)
    func errorCode(complete: CompleteBlock?, error:ErrorBlock?)
    func verifycode(verifyType: Int64, phone: String, complete: CompleteBlock?, error: ErrorBlock?)
    func test(phone: String, pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
}

