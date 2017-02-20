//
//  HistoryDealVC.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
class HistoryDealCell: OEZTableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    // 盈亏
    @IBOutlet weak var statuslb: UILabel!
    override func update(_ data: Any!) {
        if let model: PositionModel = data as! PositionModel? {
            nameLabel.text = "\(model.name)"
            timeLabel.text = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.positionTime)), format: "yyyy.MM.dd HH:mm:ss")
           //com.yundian.trip
            priceLabel.text = "¥" + String(format: "%.2f", model.openCost)
      
            statuslb.backgroundColor = model.result   ? UIColor.init(hexString: "E9573F") : UIColor.init(hexString: "0EAF56")
            
            statuslb.text =  model.result   ?  "盈" :   "亏"
    
            statuslb.layer.cornerRadius = 3
            
            statuslb.clipsToBounds = true
        }
    }
}

class HistoryDealVC: BasePageListTableViewController {

    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didRequest(_ pageIndex: Int) {

        AppAPIHelper.deal().historyDeals(start: (pageIndex - 1) * 10, count: 10, complete: { [weak self](result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                DealModel.cachePositionWithArray(positionArray: models)
                if pageIndex == 1 {
                    var newModels: [PositionModel] = []
                    let historyModels = DealModel.getHistoryPositionModel()
                    if historyModels.count == 0{
                        newModels = models
                    }else{
                        for historyModel in historyModels{
                            newModels.append(historyModel)
                        }
                        for model in models{
                            if model.positionTime > historyModels.first!.positionTime{
                                newModels.append(model)
                            }
                        }
                    }
                    self?.didRequestComplete(newModels as AnyObject?)
                }else{
                    var moreModels: [PositionModel] = []
                    let historyModels = DealModel.getHistoryPositionModel()
                    if historyModels.count == 0{
                        moreModels = models
                    }else{
                        for model in models{
                            if model.positionTime < historyModels.last!.positionTime{
                                moreModels.append(model)
                            }
                        }
                    }
                    self?.didRequestComplete(moreModels as AnyObject?)                }
            }
            return nil
        }, error: errorBlockFunc())
            
    }
}
