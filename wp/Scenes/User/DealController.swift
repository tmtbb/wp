//
//  DealController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import RealmSwift
import DKNightVersion
class DealController: BasePageListTableViewController, TitleCollectionviewDelegate {
    

    
    @IBOutlet weak var productCollection: TitleCollectionView!
    //盈亏数
    @IBOutlet weak var moneyNumber: UILabel!
    //总手数
    @IBOutlet weak var sumHandNumber: UIButton!
    //总单数
    @IBOutlet weak var sumOneNumber: UIButton!
    //买涨
    @IBOutlet weak var buyUp: UILabel!
    //买跌
    @IBOutlet weak var buyDown: UILabel!
    //建仓
    @IBOutlet weak var build: UILabel!
    //平仓
    @IBOutlet weak var sell: UILabel!
    
    @IBOutlet weak var dealBackground: UIView!
    
    
    var allData:[String:TransactionDetailModel] = [:]
    var pageIndexs:[String:Int] = [:]
    //当前选择的分组数据Model
    var currentTDModel:TransactionDetailModel?
  
    //当前选择的分组
    var currentSelectProduct:ProductModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bounces = false
        currentSelectProduct  = DealModel.share().productKinds.first
        setupCollection()
        dealBackground.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        endRefreshing()
        tableView.showsVerticalScrollIndicator = false
    }
    
    //MARK: -- 设置collectionView
    func setupCollection() {
        productCollection.itemDelegate = self
        productCollection.reuseIdentifier = ProductCollectionCell.className()
        productCollection.objects = DealModel.share().productKinds as [AnyObject]
        /*
         - 根据分组多少创建存放分组数据的model，以分组标识为Key 存放到字典
         */
        for product in DealModel.share().productKinds {
            let model = TransactionDetailModel()
            allData[product.symbol] = model
            pageIndexs[product.symbol] = 0
        }
    }
    
    /*
      - 点击分组回调
     */
    internal func didSelectedObject(_ collectionView: UICollectionView, object: AnyObject?) {
        currentSelectProduct = object as? ProductModel
        currentTDModel = allData[currentSelectProduct!.symbol]
        tableView.reloadData()
        didRequest(1)
    }
    

    
    override func isOverspreadLoadMore() -> Bool {
        return false
    }
    
    override func didRequest(_ pageIndex : Int){
        guard currentSelectProduct != nil else {return}
        let index = pageIndexs[currentSelectProduct!.symbol]
        if index! < 0 {
            return
        }
        let requestModel = DealHistoryDetailParam()
        requestModel.start = index! * 10
        requestModel.count = 10
        pageIndexs[currentSelectProduct!.symbol] = index! + 1
        requestModel.symbol = currentSelectProduct!.symbol
        AppAPIHelper.deal().requestDealDetailList(pram: requestModel, complete: { [weak self](result) -> ()?  in
            if let models: [PositionModel] = result as! [PositionModel]?{
                self?.didRequestComplete(models as AnyObject?)
                self?.setupDataWithModels(models: models)
                if models.count < 10 {
                    let model = models.first
                    self?.pageIndexs[model!.symbol!] = -1
                }
            }
            return nil
        }, error: errorBlockFunc())
    }

    /*
     - 将数据放入各分组
     - 以时间戳转化成时间为key，对应的value为 key 当天的所有数据
     */
    private func setupDataWithModels(models:[PositionModel]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MM-dd"
        for model in models {
            let tdModel = allData[model.symbol!]
            guard tdModel != nil else {
                continue
            }
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.closeTime)))
            /*
             - 判断 model 对应的分组 是否已经有当天数据信息
             - 如果已经有信息则直接将model 插入当天信息array
             - 反之，创建当天分组array 插入数据
             */
            if tdModel!.dateArray.contains(dateString) {
                tdModel!.allDataDict[dateString]!.append(model)
            } else {
                var list:[PositionModel] = Array()
                list.append(model)
                tdModel!.dateArray.append(dateString)
                tdModel!.allDataDict[dateString] = list
            }
        }
        guard currentSelectProduct != nil else { return }
        currentTDModel = allData[currentSelectProduct!.symbol]
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return currentTDModel == nil ? 0 : currentTDModel!.dateArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = currentTDModel?.allDataDict[currentTDModel!.dateArray[section]]
        
        return array == nil ? 0 : array!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealDetailCell", for: indexPath) as! DealDetailCell
        let array = currentTDModel!.allDataDict[currentTDModel!.dateArray[indexPath.section]]

        cell.setData(model: array![indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    //MARK: -- 返回组标题索引
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = currentTDModel!.dateArray[section]
        label.textColor = UIColor(rgbHex: 0x666666)
        label.font = UIFont.systemFont(ofSize: 14)
        let sumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        sumView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(sumView).offset(15)
            make.bottom.equalTo(sumView).offset(-10)
        }
        return sumView
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DealDetailTableVC.className(), sender: indexPath)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DealDetailTableVC.className() {
            let dealDetailTableVC = segue.destination as! DealDetailTableVC
            let indexPath = sender as! IndexPath
            let array = currentTDModel!.allDataDict[currentTDModel!.dateArray[indexPath.section]]
            dealDetailTableVC.positionModel = array![indexPath.row]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}






