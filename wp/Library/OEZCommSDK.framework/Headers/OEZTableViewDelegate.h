//
//  OEZTableViewDelegate.h
//  OEZCommSDK
//
//  Created by 180 on 15/2/6.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OEZTableViewDelegate <NSObject>
@optional
/**
 *  一个cell 显示多列时点击单列事件
 *
 *  @param tableView tableview
 *  @param indexPath tableview  indexPath
 *  @param column    列索引
 */
- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didSelectColumnAtIndex:(NSInteger) column;
/**
 *  cell 控件事件
 *
 *  @param tableView tableview
 *  @param indexPath tableview indexPath
 *  @param action    事件编号
 *  @param data      额外数据
 */
- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger) action data:(id) data;
@end