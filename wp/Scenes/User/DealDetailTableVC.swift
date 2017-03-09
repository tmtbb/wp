//
//  DealDetailTableVC.swift
//  wp
//
//  Created by macbook air on 17/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class DealDetailTableVC: BaseTableViewController{

    //交易类型
    @IBOutlet weak var dealType: UILabel!
    //交易品种
    @IBOutlet weak var dealProduct: UILabel!
    //交易时间
    @IBOutlet weak var dealTime: UILabel!
    //交易金额
    @IBOutlet weak var dealMoney: UILabel!
    //最底履约保证金
    @IBOutlet weak var cashDeposit: UILabel!
    //手续费率
    @IBOutlet weak var poundage: UILabel!
    
    lazy var dateFormatter:DateFormatter = {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        return dateFormatter
    }()
    var positionModel:PositionModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        title = "交易详情"
        setData()
    }
    
    func setData() {
        let isUp = (positionModel!.buySell == 1)
        let string = isUp ? "买入" : "卖出"
        dealType.text = string
        dealTime.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval((positionModel!.positionTime))))
        dealProduct.text = positionModel!.name
        dealMoney.text = String(format: "%.2f", positionModel!.openCost)
        
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
