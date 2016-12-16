//
//  OEZViewActionProtocol.h
//  OEZCommSDK
//
//  Created by yaobanglin on 15/8/31.
//  Copyright (c) 2015年 180. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol OEZViewActionProtocol <NSObject>
@optional
/**
 *  didAction 事件
 *
 *  @param view   事件view
 *  @param action 事件编号
 *  @param data   额外数据
 */
- (void) view:(UIView *)view  didAction:(NSInteger) action data:(id) data;
@end
