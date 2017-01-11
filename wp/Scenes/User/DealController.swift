//
//  DealController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
class DealController: BaseTableViewController {
    
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
     var lastTypeBtn: UIButton?
     var index: NSInteger = 0
     

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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    //MARK: -- 设置collectionView
    func setupCollection() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height: 50)
        productCollection.delegate = self
        productCollection.dataSource = self
        productCollection.isPagingEnabled = true
        productCollection.bounces = false
        
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
        return 5
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

}
//MARK: -- collectionView的代理方法
extension DealController:UICollectionViewDataSource, UICollectionViewDelegate{
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productTypeCell", for: indexPath) as! ProductCollectionCell
        cell.productBtn.setTitle("白银", for: UIControlState.normal)
        cell.productBtn.setTitleColor(UIColor(rgbHex: 0x333333), for: UIControlState.normal)
        cell.productBtn.setTitleColor(UIColor(rgbHex: 0xE9573E), for: .selected)
        cell.productBtn.tag = indexPath.item + 300
        cell.productBtn.addTarget(self, action: #selector(btnDidClick), for: UIControlEvents.touchUpInside)
//        cell.redView.isHidden = false
//        if indexPath.item == 0 {
//            btnDidClick(sender: cell.btn)
////            cell.redView.isHidden = false
//        }
        return cell
    }
    
    func btnDidClick(sender: UIButton) {
        let number = sender.tag
        print(number)
        lastTypeBtn?.isSelected = false
        sender.isSelected = true
        lastTypeBtn = sender
    }
  
 
}





