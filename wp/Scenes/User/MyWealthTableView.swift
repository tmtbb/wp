//
//  MywealthTableView.swift
//  wp
//
//  Created by sum on 2017/1/8.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MyWealthTableView: UITableView ,UITableViewDelegate, UITableViewDataSource{
    
    var refreshController =  UIRefreshControl()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        rowHeight = 66
        refreshController.addTarget(self, action: #selector(refreshData),
                             for: .valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.addSubview(refreshController)
    }
    func refreshData() {
        //移除老数据
        
        self.refreshController.endRefreshing()
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    //     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //
    //        if section == 0 {
    //            headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
    //
    //
    //            monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
    //            monthLb.text = "12 月"
    //
    //            headerView.addSubview(monthLb)
    //
    //            self.monthLb.text = "本月收益"
    //            return headerView
    //
    //        }
    //        if section == 1 {
    //
    //            headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
    //
    //
    //            monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
    //            monthLb.text = "12 月"
    //
    //            headerView.addSubview(monthLb)
    //            self.monthLb.text = "12"
    //
    //            return headerView
    //
    //        }
    //
    //        return headerView
    //    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWealtVCCell", for: indexPath)
        
        
        return cell
    }
    
}
