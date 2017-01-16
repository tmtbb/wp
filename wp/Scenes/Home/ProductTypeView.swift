//
//  ProductTypeView.swift
//  wp
//
//  Created by macbook air on 17/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit



class ProdectCell: UITableViewCell {
    
    //产品名字
    @IBOutlet weak var productName: UILabel!
    //现价
    @IBOutlet weak var nowPrice: UILabel!
    //今开
    @IBOutlet weak var todayOpen: UILabel!
    //昨开
    @IBOutlet weak var yesterdayOpen: UILabel!
    //最高
    @IBOutlet weak var hightPrice: UILabel!
    //最底
    @IBOutlet weak var lowPrice: UILabel!
    //变化价格
    @IBOutlet weak var changeLabel: UILabel!
    //变化百分比:计算
    @IBOutlet weak var changePer: UILabel!
    
    
    
    var model: KChartModel? {
        didSet{
            if model == nil {
                return
            }
            productName.text = model!.goodType
            nowPrice.text = "\(model!.currentPrice)"
            todayOpen.text = "\(model!.openingTodayPrice)"
            yesterdayOpen.text = "\(model!.closedYesterdayPrice)"
            hightPrice.text = "\(model!.highPrice)"
            lowPrice.text = "\(model!.lowPrice)"
            changeLabel.text = "\(model!.change)"
            
            let screenW = UIScreen.main.bounds.width / 375
            //        productName.font = UIFont.systemFont(ofSize: 25 * screenW)
            nowPrice.font = UIFont.systemFont(ofSize: 25 * screenW)
            todayOpen.font = UIFont.systemFont(ofSize: 13 * screenW)
            yesterdayOpen.font = UIFont.systemFont(ofSize: 13 * screenW)
            hightPrice.font = UIFont.systemFont(ofSize: 13 * screenW)
            lowPrice.font = UIFont.systemFont(ofSize: 13 * screenW)
            changeLabel.font = UIFont.systemFont(ofSize: 13 * screenW)
            changePer.font = UIFont.systemFont(ofSize: 13 * screenW)
        }
    }

}

class ProductTypeView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    
    var productTableData: [KChartModel]? {
        didSet{
            reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        rowHeight = 96
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return productTableData == nil ? 0 : (productTableData?.count)!
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdectCell", for: indexPath) as! ProdectCell
        cell.model = productTableData?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            print("0000000")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
