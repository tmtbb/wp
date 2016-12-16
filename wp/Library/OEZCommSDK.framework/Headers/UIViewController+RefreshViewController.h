//
// Created by yaowang on 16/4/18.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIViewController (RefreshViewController)

- (void)setupRefreshControl;
- (BOOL)autoRefreshLoad;
- (BOOL)refreshWhiteMode;
- (void)removeRefreshControl;
- (void)performSelectorRemoveRefreshControl;
- (void)beginRefreshing;
- (void)endRefreshing;
- (UIScrollView *)contentScrollView;
- (void)didRequest;
@end