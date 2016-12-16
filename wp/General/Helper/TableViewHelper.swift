//
//  TableViewHelper.swift
//  viossvc
//
//  Created by yaowang on 2016/11/1.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


protocol TableViewHelperProtocol {
    //获取Cell ReuseIdentifier
    func tableView(_ tableView:UITableView ,cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String?;
    //获取Cell数据
    func tableView(_ tableView:UITableView ,cellDataForRowAtIndexPath indexPath: IndexPath) -> AnyObject?;
    //是否从cell类中计算高度，默认false
    func isCalculateCellHeight() -> Bool;
    //是否缓存cell高度，默认false,当为true时,cell类中计算高度自动打开
    func isCacheCellHeight() -> Bool;
    //是否为多组方式取数据,默认false
    func isSections() ->Bool;
}

//#MARK: -TableViewHelper
class TableViewHelper {
   fileprivate var cacheCellClasss:Dictionary<String,AnyClass> = Dictionary<String,AnyClass>();
   fileprivate var classCellNoFountCalculateHeights:Array<String> = Array<String>();
   fileprivate var cacheCellHeights:Dictionary<IndexPath,CGFloat> = Dictionary<IndexPath,CGFloat>();
    

    //默认ReuseIdentifier前缀
    var defaultCellIdentifier:String? = nil;
    
    //默认ReuseIdentifier前缀+Cell,多组时section非0前缀+Cell+section
    func tableView<T:UIViewController>(_ tableView:UITableView ,cellIdentifierForRowAtIndexPath indexPath: IndexPath,controller:T) -> String? where T:TableViewHelperProtocol {
        if( defaultCellIdentifier == nil ) {
            defaultCellIdentifier = controller.classForCoder.className();
            for  target:String in ["ViewController","Controller"] {
                if defaultCellIdentifier!.hasSuffix(target) {
                    defaultCellIdentifier = defaultCellIdentifier?.replacingOccurrences(of: target, with: "");
                    break;
                }
            }
            defaultCellIdentifier?.append("Cell");
        }
        return indexPath.section != 0 ? defaultCellIdentifier! + String(indexPath.section) : defaultCellIdentifier;
    }
    
    func tableView<T:UIViewController>(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath,controller:T) -> UITableViewCell where T:TableViewHelperProtocol {
        let identifier:String? = controller.tableView(tableView, cellIdentifierForRowAtIndexPath: indexPath);
        return tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath);
    }
    
    func tableView<T:UIViewController>(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath,controller:T) where T:TableViewHelperProtocol {
       if cell.conforms(to: OEZUpdateProtocol.self)  {
            (cell as! OEZUpdateProtocol).update(controller.tableView(tableView, cellDataForRowAtIndexPath: indexPath));
        }
    }
    
    func calculateCellHeight<T:UIViewController>(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath,controller:T) -> CGFloat where T:TableViewHelperProtocol {
        let identifier:String? = controller.tableView(tableView,cellIdentifierForRowAtIndexPath:indexPath);
        var cellClass:AnyClass? = nil;
        if identifier != nil {
            cellClass = cacheCellClasss[identifier!];
            if cellClass == nil {
                if( !classCellNoFountCalculateHeights.contains(identifier!) ) {
                    cellClass =  NSClassFromString("viossvc."+identifier!);
                    if cellClass != nil && cellClass!.conforms(to: OEZCalculateProtocol.self)
                        && cellClass!.calculateHeight(withData:) != nil {
                        cacheCellClasss[identifier!] = cellClass!;
                    }
                    else {
                        classCellNoFountCalculateHeights.append(identifier!);
                        cellClass = nil;
                    }
                }
            }
        }
        return cellClass == nil ? CGFloat.greatestFiniteMagnitude : cellClass!.calculateHeight(withData: controller.tableView(tableView, cellDataForRowAtIndexPath: indexPath));
    }
    
    
    func tableView<T:UIViewController>(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath,controller:T) -> CGFloat where T:TableViewHelperProtocol {
        var cellHeight:CGFloat? = cacheCellHeight(indexPath);
        if !controller.isCacheCellHeight() || cellHeight == nil {
            cellHeight = calculateCellHeight(tableView, heightForRowAtIndexPath: indexPath, controller: controller);
            if controller.isCacheCellHeight() && cellHeight != CGFloat.greatestFiniteMagnitude {
                cacheCellHeights[indexPath] = cellHeight;
            }
        }
        return cellHeight!;
    }
    
    
    func didRequestComplete<T:UIViewController>(_ dataSource:inout Array<AnyObject>?,pageDatas:Array<AnyObject>?,controller:T) where T:TableViewHelperProtocol {
        if controller.pageIndex == 1 {
            dataSource = pageDatas;
        }
        else {
            if( pageDatas?.count > 0 ) {
                dataSource?.append(contentsOf: pageDatas!)
                controller.endLoadMore();
            }
            else {
                controller.notLoadMore();
            }
        }
        controller.setIsLoadData(true);
    }
    // MARK: - cacheCellClass
    func addCacheCellClass<T:UITableViewCell>(_ type:T.Type,cellIdentifier:String) {
        cacheCellClasss[cellIdentifier] = type;
    }
    
    // MARK: - CacheCellHeight
    func removeCacheCellHeight(_ indexPath: IndexPath) ->Bool {
        return cacheCellHeights.removeValue(forKey: indexPath) != nil;
    }
    
    func removeCacheCellHeights(_ indexPaths:Array<IndexPath>)  {
        for indexPath in indexPaths {
            removeCacheCellHeight(indexPath);
        }
    }
    
    func addCacheCellHeight(_ height:CGFloat , indexPath: IndexPath)  {
        cacheCellHeights[indexPath] = height;
    }
    
    func removeAllCacheCellHeight() {
        cacheCellHeights.removeAll();
    }
    
    func cacheCellHeight(_ indexPath: IndexPath) -> CGFloat? {
        return cacheCellHeights[indexPath];
    }

}
