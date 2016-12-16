//
// Created by yaobanglin on 15/9/1.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface UIViewController (OEZUIViewControllerCategory)<UIAlertViewDelegate>


-(MBProgressHUD*) getMBProgressHUD;
- (void) removeMBProgressHUD;
/**
*  显示Progress
*
*  @param mode 模式
*  @param msg  显示文本
*/
-(void) showProgress:(MBProgressHUDMode) mode msg:(NSString*) msg;
/**
*  显示Progress
*
*  @param msg 显示文本
*/
-(void) showLoader:(NSString*) msg;
/**
*  显示 tips 默认显示2.5秒
*
*  @param msg 显示文本
*/
-(void) showTips:(NSString*) msg ;
/**
*  显示 tips
*
*  @param msg   显示文本
*  @param delay 显示秒数
*/
-(void) showTips:(NSString*) msg afterDelay:(NSTimeInterval)delay;
/**
*  隐藏Progress
*/
-(void) hiddenProgress;
-(void) showError:(NSError*) error;

-(void) hideKeyboard;
@end