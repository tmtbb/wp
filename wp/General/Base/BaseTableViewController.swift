//
//  BaseTableViewController.swift
//  viossvc
//
//  Created by yaowang on 2016/10/27.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation
import SVProgressHUD

class BaseTableViewController: UITableViewController , TableViewHelperProtocol {
    
    var tableViewHelper:TableViewHelper = TableViewHelper();
    
    override  func viewDidLoad() {
        super.viewDidLoad();
        if tableView.tableFooterView == nil {
            tableView.tableFooterView = UIView(frame:CGRect(x: 0,y: 0,width: 0,height: 0.5));
        }
    }
    //友盟页面统计
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView(NSStringFromClass(self.classForCoder))
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.beginLogPageView(NSStringFromClass(self.classForCoder))
        SVProgressHUD.dismiss()
    }
    //MARK:TableViewHelperProtocol
    func isCacheCellHeight() -> Bool {
        return false;
    }
    
    func isCalculateCellHeight() ->Bool {
        return isCacheCellHeight();
    }
    
    func isSections() ->Bool {
        return false;
    }
    
    func tableView(_ tableView:UITableView ,cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return tableViewHelper.tableView(tableView, cellIdentifierForRowAtIndexPath: indexPath, controller: self);
    }
    
    func tableView(_ tableView:UITableView ,cellDataForRowAtIndexPath indexPath: IndexPath) -> AnyObject? {
        return nil;
    }
    
    //MARK: -UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = super.tableView(tableView,cellForRowAt:indexPath);
        if cell == nil {
            cell = tableViewHelper.tableView(tableView, cellForRowAtIndexPath: indexPath, controller: self);
        }
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewHelper.tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath, controller: self);
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if( isCalculateCellHeight() ) {
            let cellHeight:CGFloat = tableViewHelper.tableView(tableView, heightForRowAtIndexPath: indexPath, controller: self);
            if( cellHeight != CGFloat.greatestFiniteMagnitude ) {
                return cellHeight;
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath);
    }
    
    
}
class BaseRefreshTableViewController :BaseTableViewController {
    
    override  func viewDidLoad() {
        super.viewDidLoad();
        self.setupRefreshControl();
    }

   internal func completeBlockFunc()->CompleteBlock {
        return { [weak self] (obj) in
            self?.didRequestComplete(obj)
        }
    }

   internal func didRequestComplete(_ data:AnyObject?) {
        endRefreshing()
        self.tableView.reloadData()
    }
    
    override func didRequestError(_ error:NSError) {
        self.endRefreshing()
        super.didRequestError(error)
    }
    
    deinit {
        performSelectorRemoveRefreshControl();
    }
}


class BaseListTableViewController :BaseRefreshTableViewController {
    internal var dataSource:Array<AnyObject>?;
    
    override func didRequestComplete(_ data: AnyObject?) {
        dataSource = data as? Array<AnyObject>;
        super.didRequestComplete(dataSource as AnyObject?);
        
    }
    
   //MARK: -UITableViewDelegate
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var count:Int = dataSource != nil ? 1 : 0;
        if  isSections() && count != 0 {
            count =  dataSource!.count;
        }
        return count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var datas:Array<AnyObject>? = dataSource;
        if  dataSource != nil && isSections()  {
            datas = dataSource![section] as? Array<AnyObject>;
            
        }
        return datas == nil ? 0 : datas!.count;
    }
    
    //MARK:TableViewHelperProtocol
    override func tableView(_ tableView:UITableView ,cellDataForRowAtIndexPath indexPath: IndexPath) -> AnyObject? {
        var datas:Array<AnyObject>? = dataSource;
        if dataSource != nil && isSections() {
            datas = dataSource![indexPath.section] as? Array<AnyObject>;
        }
        return  (datas != nil && datas!.count > indexPath.row ) ? datas![indexPath.row] : nil;
    }
    
}


class BasePageListTableViewController :BaseListTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        setupLoadMore();
    }
    
    
    override func didRequestComplete(_ data: AnyObject?) {
        tableViewHelper.didRequestComplete(&self.dataSource,
                                           pageDatas: data as? Array<AnyObject>, controller: self);
        super.didRequestComplete(self.dataSource as AnyObject?);
    }
    
    override func didRequestError(_ error:NSError) {
        if (!(self.pageIndex == 1) ) {
            self.errorLoadMore()
        }
        self.setIsLoadData(true)
        super.didRequestError(error)
    }
    
    deinit {
        removeLoadMore();
    }
}
