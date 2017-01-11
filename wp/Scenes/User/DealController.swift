//
//  DealController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
class DealController: BaseTableViewController, TitleCollectionviewDelegate {
    
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
    

    let strArray:[String] = ["周五 12 - 26","周四 12 - 25","周三 12 - 24","周二 12 - 23","周一 12 - 22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
  
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 15, y: 5, width: 38, height: 38)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(backDidClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
    }
    func backDidClick() {
        navigationController?.popToRootViewController(animated: true)
    }
   
    
    //MARK: -- 设置collectionView
    func setupCollection() {
        productCollection.itemDelegate = self
        productCollection.reuseIdentifier = ProductCollectionCell.className()
        productCollection.objects = ["test1" as AnyObject,"test2" as AnyObject,"test1" as AnyObject,"test2" as AnyObject,"test1" as AnyObject,"test2" as AnyObject]
    }
    func didSelectedProduct(object: AnyObject?) {
        if let test: String = object as? String {
            print(test)
        }
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
    //MARK: -- 隐藏tabBar导航栏
    func hideTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        
        var tabFrame = tabBar?.frame
        tabFrame?.origin.y = (window?.bounds)!.maxY
        tabBar?.frame = tabFrame!
        content?.frame = (window?.bounds)!
    }
    
    func showTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        var tabFrame = tabBar?.frame
        tabFrame?.origin.y = (window?.bounds)!.maxY - ((tabBar?.frame)?.height)!
        tabBar?.frame = tabFrame!
        var contentFrame = content?.frame
        contentFrame?.size.height -= (tabFrame?.size.height)!
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
    
    //不能向上滑动
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






