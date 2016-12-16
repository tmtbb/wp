//
//  UITabBar+Badge.h
//  mgame648
//
//  Created by yaowang on 15/12/7.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

//- (void)showBadgeOnItemIndex:(int)index offset:(UIOffset)offset;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
