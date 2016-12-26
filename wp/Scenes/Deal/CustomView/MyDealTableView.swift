//
//  MyDealTableView.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class MyDealCell: UITableViewCell {

    @IBOutlet weak var dealNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var sellBtn: UIButton!

}

class MyDealTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        rowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyDealCell = tableView.dequeueReusableCell(withIdentifier: "dealCell") as! MyDealCell
        return cell
    }
}
