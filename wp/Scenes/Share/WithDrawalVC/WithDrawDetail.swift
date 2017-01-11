//
//  WithDrawDetail.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 提现详情
class WithDrawDetail: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "提现详情"
    }

    // 请求接口
    override func didRequest() {
        
        AppAPIHelper.user().creditdetail(rid:1111000011, complete: { (result) -> ()? in
            //              self?.didRequestComplete(result)
            return nil
        }, error: errorBlockFunc())
        
    }

}
