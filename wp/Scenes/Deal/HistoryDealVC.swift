//
//  HistoryDealVC.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
import DKNightVersion
class HistoryDealCell: OEZTableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    // 盈亏
    @IBOutlet weak var statuslb: UILabel!
    override func update(_ data: Any!) {
        if let model: PositionModel = data as! PositionModel? {
            print(model.description)
            nameLabel.text = "\(model.name)"
            timeLabel.text = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.closeTime)), format: "yyyy.MM.dd HH:mm:ss")
           //com.yundian.trip
            priceLabel.text = "¥" + String(format: "%.2f", model.openCost)
            priceLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)

            statuslb.backgroundColor = model.result   ? UIColor.init(hexString: "E9573F") : UIColor.init(hexString: "0EAF56")
            statuslb.text =  model.result   ?  "盈" :   "亏"
            titleLabel.text = model.buySell == 1 ? "买入" : "卖出"
            openLabel.text = "\(model.openPrice)"
            closeLabel.text = "\(model.closePrice)"
            handleLabel.text = ""
//            let handleText =  [" 未操作 "," 双倍返还 "," 货运 "," 退舱 "]
//
//            if model.handle < handleText.count{
//                handleLabel.text = handleText[model.handle]
//            }
            
            if model.buySell == -1 && UserModel.share().currentUser?.type == 0 && model.result == false{
                handleLabel.backgroundColor = UIColor.clear
                handleLabel.text = ""
            }else if model.handle == 0{
                handleLabel.backgroundColor = UIColor.init(rgbHex: 0xc2cfd7)
            }else{
                handleLabel.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
            }
        }
    }
}

class HistoryDealVC: BasePageListTableViewController {
    
    var historyModels: [PositionModel] = []
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didRequest(_ pageIndex: Int) {
        historyModels = dataSource == nil ? [] : dataSource as! [PositionModel]
        let index =  pageIndex == 1 ? 0: historyModels.count
        let param = UndealParam()
        param.start = index
        param.count = 10
        AppAPIHelper.deal().historyDeals(param: param, complete: { [weak self](result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                if pageIndex == 1 {
                    self?.didRequestComplete(models as AnyObject?)
                }else{
                    var moreModels: [PositionModel] = []
                    for model in models{
                        if model.closeTime < (self?.historyModels.last!.closeTime)!{
                            moreModels.append(model)
                        }
                    }
                    self?.didRequestComplete(moreModels as AnyObject?)
                }
            }
            return nil
        }, error: errorBlockFunc())
            
    }
    
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.dataSource?[indexPath.row] as? PositionModel{
            if let controller = storyboard?.instantiateViewController(withIdentifier: DealDetailTableVC.className()) as? DealDetailTableVC{
                controller.positionModel = model
                _ = navigationController?.pushViewController(controller, animated: true)
            }
            return
           
        }
    }
}
