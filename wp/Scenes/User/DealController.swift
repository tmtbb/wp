//
//  DealController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
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
    var allDataDict:[String:Array<PositionModel>] = Dictionary()
    var dateArray:[String] = Array()
    
    var currentSelectProduct:ProductModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSelectProduct  = DealModel.share().productKinds.first
        setupCollection()
        
        dealBackground.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        sumHandNumber.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.lightBlue)
        sumOneNumber.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.lightBlue)
        beginRefreshing()
        
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        requstTotalHistroy()
    }
    
    //MARK: -- 设置collectionView
    func setupCollection() {
        productCollection.itemDelegate = self
        productCollection.reuseIdentifier = ProductCollectionCell.className()
        productCollection.objects = DealModel.share().productKinds as [AnyObject]
    }
    
    internal func didSelectedObject(_ collectionView: UICollectionView, object: AnyObject?) {

        currentSelectProduct = object as? ProductModel
        setupDataWithFilter(filter: "symbol == '\(currentSelectProduct!.symbol)'")
    }
    
    func requstTotalHistroy() {
        
        AppAPIHelper.user().getTotalHistoryData(complete: { [weak self](result) -> ()? in
            if let model = result as? TotalHistoryModel {
                self?.moneyNumber.text = String(format: "%.2f", model.profit)
                self?.sumHandNumber.setTitle("\(model.amount)", for: .normal)
                self?.sumOneNumber.setTitle("\(model.count)", for: .normal)
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    override func didRequest(_ pageIndex : Int){
        let index = (pageIndex - 1) * 10
        AppAPIHelper.deal().historyDeals(start: index, count: 10, complete: { [weak self](result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                DealModel.cachePositionWithArray(positionArray: models)
                self?.didRequestComplete(models as AnyObject?)
                self?.setupDataWithFilter(filter: "symbol == '\((self?.currentSelectProduct?.symbol)!)'")
            }
            
            return nil
            }, error: errorBlockFunc())
    }
    private func setupDataWithFilter(filter:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MM-dd"
        let recordList = DealModel.getHistoryPositionModel().filter(filter)
        dateArray.removeAll()
        allDataDict.removeAll()
        for model in recordList {
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.closeTime)))
            if dateArray.contains(dateString) {
                allDataDict[dateString]!.append(model)
            } else {
                var list:[PositionModel] = Array()
                list.append(model)
                dateArray.append(dateString)
                allDataDict[dateString] = list
            }
        }
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dateArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = allDataDict[dateArray[section]]
        
        return array == nil ? 0 : array!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealDetailCell", for: indexPath) as! DealDetailCell
        let array = allDataDict[dateArray[indexPath.section]]

        cell.setData(model: array![indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    //MARK: -- 返回组标题索引
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = dateArray[section]
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
    
    //禁止向上滑动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let off_y = scrollView.contentOffset.y
        if off_y < 0 {
            self.tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DealDetailTableVC.className(), sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DealDetailTableVC.className() {
            let dealDetailTableVC = segue.destination as! DealDetailTableVC
            let indexPath = sender as! IndexPath
            let array = allDataDict[dateArray[indexPath.section]]
            dealDetailTableVC.positionModel = array![indexPath.row]
        }
        
    }
}






