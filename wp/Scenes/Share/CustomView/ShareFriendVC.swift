//
//  ShareFriendVC.swift
//  wp
//
//  Created by sum on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ShareFriendVC: BaseCustomPageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func didRequest(_ pageIndex : Int) {
        didRequestComplete(["",""] as AnyObject)
        
        //注释掉  请求接口有的时候再打开
        //        AppAPIHelper.share().getShareData(userId: "123", phone: "15306559323", selectIndex: "1223", pageNumber: "0", complete: { (result ) -> ()? in
        //
        //            return nil
        //        }, error: errorBlockFunc())
        //        print(errorBlockFunc)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

   

}
