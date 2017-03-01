//
//  MyDealTableView.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
protocol CellDelegate: NSObjectProtocol {
    func cellBtnTapped(model: PositionModel)
}

class MyDealCell: UITableViewCell {
    var model: PositionModel? {
        didSet{
            if model == nil {
                return
            }
            dealNameLabel.text = model!.name
            countLabel.text = "\(model!.amount)G"
            priceLabel.text = "\(model!.openPrice)"
            winLabel.text = "\(model!.grossProfit)"
        }
    }
    weak var delegate: CellDelegate?

    @IBOutlet weak var dealNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var sellBtn: UIButton!
    
    
    @IBAction func sellOut(_ sender: Any) {
        if let myDelegate = delegate{
            myDelegate.cellBtnTapped(model: model!)
        }
    }

}

class MyDealTableView: UITableView,UITableViewDataSource, UITableViewDelegate {
    var dataArray: Results<PositionModel>?
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        register(DealListCell.self, forCellReuseIdentifier: "DealListCell")
        rowHeight = 66
        dataSource = self
        delegate = self
        isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        register(DealListCell.self, forCellReuseIdentifier: "DealListCell")
        rowHeight = 66
        dataSource = self
        delegate = self
        isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray == nil ? 0 : dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "DealListCell", for: indexPath) as! DealListCell
        cell.setData(positionModel: dataArray![indexPath.row])
        return cell
    }
    
    
    
}

//class MyDealTableView: UITableView, UITableViewDelegate, UITableViewDataSource, CellDelegate {
//    
//    var dealTableData: [PositionModel]? {
//        didSet{
//            reloadData()
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        delegate = self
//        dataSource = self
//        rowHeight = 60
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dealTableData == nil ? 0 : (dealTableData?.count)!
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: MyDealCell = tableView.dequeueReusableCell(withIdentifier: "dealCell") as! MyDealCell
//        let model = dealTableData?[indexPath.row]
//        cell.model = model
//        cell.delegate = self
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = dealTableData?[indexPath.row]
//        DealModel.share().type = .cellTapped
//        DealModel.share().selectDealModel = model
//    }
//    func cellBtnTapped(model: PositionModel) {
//        DealModel.share().type = .btnTapped
//        DealModel.share().selectDealModel = model
//    }
//}
