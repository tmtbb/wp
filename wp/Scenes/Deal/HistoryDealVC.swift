//
//  HistoryDealVC.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class HistoryDealCell: OEZTableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    
    override func update(_ data: Any!) {
        if let model: PositionModel = data as! PositionModel? {
            nameLabel.text = "\(model.name!)\(model.openCost)(元/千克)"
            timeLabel.text = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.positionTime)), format: "yyyy.MM.dd HH:mm:ss")
            priceLabel.text = "\(model.openPrice)元/100g"
            winLabel.text = model.limit > 0 ? "止盈\(model.limit*10)%" : "止盈无"
            failLabel.text = model.stop > 0 ? "止损\(model.stop*10)%" : "止损无"
        }
    }
}

class HistoryDealVC: BasePageListTableViewController {
    var models: [PositionModel] = []
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func didRequest(_ pageIndex: Int) {
        initData()
    }
    //MARK: --DATA
    func initData() {
        AppAPIHelper.deal().historyDeals(complete: {[weak self] (result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                self?.models = (self?.models)! + models
                self?.didRequestComplete(self?.models as AnyObject?)
            }
            return nil
        }, error: errorBlockFunc())
    }
    //MARK: --UI
    func initUI() {
        tableView.rowHeight = 75
    }

}
