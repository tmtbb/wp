//
//  DealController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
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
    
    var flowListArray: [FlowOrdersList] =  [FlowOrdersList]()
    
    let strArray:[String] = ["周五 12 - 26","周四 12 - 25","周三 12 - 24","周二 12 - 23","周一 12 - 22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        //1029 流水列表
        AppAPIHelper.user().flowList(flowType: "1,2,3", startPos: 0, count: 10, complete: { (result) -> ()? in
            
            if result != nil {
            if let dataArray: [FlowOrdersList] = result as! [FlowOrdersList]?{
                for model in dataArray{
                    self.flowListArray.append(model)
                }
                print("我是数组分割线")
                print(self.flowListArray)
                print("我是数组元素分割线")
                print(self.flowListArray[0].amount)
            }
            }else
            {
                print("nil")
            }
            return nil
        }, error: errorBlockFunc())
        
    }
    
    //MARK: -- 设置collectionView
    func setupCollection() {
        productCollection.itemDelegate = self
        productCollection.reuseIdentifier = ProductCollectionCell.className()
        productCollection.objects = ["上海-法兰克福" as AnyObject,"上海-纽约" as AnyObject,"上海-东京" as AnyObject]
    }
    func didSelectedProduct(object: AnyObject?) {
        if let test: String = object as? String {
            print(test)
        }
        //        func didSelectedObjects(object: AnyObject?) {
        //            if let product = object as? ProductModel {
        //                DealModel.share().selectProduct = product
        //            }
        //        }
    }
    
    override func didRequest(_ pageIndex : Int){
        didRequestComplete(["",""] as AnyObject)
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealDetailCell", for: indexPath) as! DealDetailCell
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    internal func didSelectedObject(_ collectionView: UICollectionView, object: AnyObject?) {
        
    }
    //MARK: -- 返回组标题索引
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = strArray[section]
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
    
    //禁止向上滑动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let off_y = scrollView.contentOffset.y
        if off_y < 0 {
            self.tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: DealDetailTableVC.className(), sender: nil)
        
    }
}






