//
//  ShareApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol ShareApi {
    
     /**我的晒单网络请求**/
     func ShareSortData(userId : String, phone: String,selectIndex: String,pageNumber: String, complete: CompleteBlock?, error: ErrorBlock?)

}
