//
//  OEZBaseView.h
//  OEZCommSDK
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZViewActionProtocol.h"
#import "OEZUpdateProtocol.h"
/**
 *  View基类
 */
@interface OEZBaseView : UIView<OEZUpdateProtocol>
/**
 *  事件分发代理
 */
@property(nonatomic,weak) id<OEZViewActionProtocol>     delegate;
/**
 *  调用代理分发事件
 *
 *  @param action 事件编号
 */
- (void) didAction:(NSInteger) action;
/**
 *   调用代理分发事件
 *
 *  @param action 事件编号
 *  @param data   额外数据
 */
- (void) didAction:(NSInteger) action data:(id) data;
@end
