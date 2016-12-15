//
//  OEZTableViewCell.h
//  OEZCommSDK
//
//  Created by 180 on 14/9/21.
//  Copyright (c) 2014年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZUpdateProtocol.h"
/**
 *  自己定义tableviewcell
 */
@interface OEZTableViewCell : UITableViewCell<OEZUpdateProtocol>
/**
 *  一个cell 显示多列时点击单列事件
 *
 *  @param column    列索引
 */
-(void) didSelectRowColumn:(NSUInteger) column;
/**
 *  cell 控件事件
 *
 *  @param action    事件编号
 */
-(void) didSelectRowAction:(NSUInteger) action;
/**
 *  cell 控件事件
 *
 *  @param action    事件编号
 *  @param data      额外数据
 */
-(void) didSelectRowAction:(NSUInteger) action data:(id) data;


@end

@protocol OEZTableViewCellProtocol <NSObject>
+ (CGFloat) calculateHeightWithData:(id) data;
@end

@interface OEZTableViewNibOwnerCell : OEZTableViewCell
-(NSString*) nibOwnerName;
@end
