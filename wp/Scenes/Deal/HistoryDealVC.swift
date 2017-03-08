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
            timeLabel.text = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.closeTime)), format: "yyyy.MM.dd HH:mm:ss")
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
        
        let index = (pageIndex - 1) * 10
//        let index = pageIndex == 1 ? 0 : DealModel.getHistoryPositionModel().count
        AppAPIHelper.deal().historyDeals(start: index, count: 10, complete: { [weak self](result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                DealModel.cachePositionWithArray(positionArray: models)
//                if pageIndex == 1 {
//                    var newModels: [PositionModel] = []
//                    let historyModels = DealModel.getHistoryPositionModel()
//                    if historyModels.count == 0{
//                        newModels = models
//                    }else{
//                        for historyModel in historyModels{
//                            newModels.append(historyModel)
//                        }
//                        for model in models{
//                            if model.positionTime > historyModels.first!.positionTime{
//                                newModels.append(model)
//                            }
//                        }
//                    }
//                    self?.didRequestComplete(newModels as AnyObject?)
//                }else{ 
//                    var moreModels: [PositionModel] = []
//                    let historyModels = DealModel.getHistoryPositionModel()
//                    if historyModels.count == 0{
//                        moreModels = models
//                    }else{
//                        for model in models{
//                            if model.positionTime < historyModels.last!.positionTime{
//                                moreModels.append(model)
//                            }
//                        }
//                    }
                
                    self?.didRequestComplete(models as AnyObject?)
//            }
            }
            return nil
        }, error: errorBlockFunc())
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.dataSource?[indexPath.row] as? PositionModel{
            if true || model.result{
                let param = BenifityParam()
                let alterController = UIAlertController.init(title: "恭喜盈利", message: "请选择盈利方式", preferredStyle: .alert)
                let productAction = UIAlertAction.init(title: "货运", style: .default, handler: {[weak self] (resultDic) in
                    AppAPIHelper.deal().benifity(param: param, complete: { (result) -> ()? in
                        
                        return nil
                    }, error: self?.errorBlockFunc())
                })
                let moneyAction = UIAlertAction.init(title: "双倍返回", style: .default, handler: { [weak self](resultDic) in
                    AppAPIHelper.deal().benifity(param: param, complete: { (result) -> ()? in
                        
                        return nil
                    }, error: self?.errorBlockFunc())
                })
                alterController.addAction(productAction)
                alterController.addAction(moneyAction)
                present(alterController, animated: true, completion: nil)
            }
        }
    }
}
