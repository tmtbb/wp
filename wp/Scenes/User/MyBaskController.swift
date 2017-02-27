//
//  MyBaskController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class MyBaskController: BasePageListTableViewController {
    
    let pushNumber = UILabel()
    let pushToday = UILabel()
    let pushWeek = UILabel()
    let pushMonthly = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = setupHeaderView()
    }
  
    
    func setupHeaderView()->(UIView) {
        let bigSumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        let sumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        sumView.backgroundColor = UIColor(rgbHex:0xFFFFFF)
        let imageView = UIImageView(image: UIImage(named: "icon-13.png"))
        let grayView = UIView()
        sumView.addSubview(pushNumber)
        sumView.addSubview(pushToday)
        sumView.addSubview(pushWeek)
        sumView.addSubview(pushMonthly)
        sumView.addSubview(imageView)
        bigSumView.addSubview(sumView)
        bigSumView.addSubview(grayView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(sumView).offset(18)
            make.top.equalTo(sumView).offset(17)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        pushNumber.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.top.equalTo(sumView).offset(18)
            make.height.equalTo(15)
        }
        pushNumber.text = "推单总数: 20"
        pushNumber.sizeToFit()
        pushNumber.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushNumber.textColor = UIColor(rgbHex:0x333333)
        //本月
        pushMonthly.snp.makeConstraints { (make) in
            make.right.equalTo(sumView).offset(-15)
            make.top.equalTo(sumView).offset(18)
            make.height.equalTo(15)
        }
        pushMonthly.text = "本月8"
        pushMonthly.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushMonthly.textColor = UIColor(rgbHex:0x333333)
        //本周
        pushWeek.snp.makeConstraints { (make) in
            make.right.equalTo(pushMonthly.snp.left).offset(-20)
            make.top.equalTo(pushMonthly)
            make.height.equalTo(15)
        }
        pushWeek.text = "本周3"
        pushWeek.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushWeek.textColor = UIColor(rgbHex:0x333333)
        //今日
        pushToday.snp.makeConstraints { (make) in
            make.right.equalTo(pushWeek.snp.left).offset(-20)
            make.top.equalTo(pushMonthly)
            make.height.equalTo(15)
        }
        pushToday.text = "今日3"
        pushToday.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushToday.textColor = UIColor(rgbHex:0x333333)
        
        //灰色的线
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(sumView.snp.bottom)
            make.left.equalTo(bigSumView)
            make.right.equalTo(bigSumView)
            make.bottom.equalTo(bigSumView)
        }
        grayView.backgroundColor = UIColor(rgbHex:0xF6F7FB)
        
        return bigSumView
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func didRequest(_ pageIndex : Int){
        didRequestComplete(["",""] as AnyObject)
    }

}
