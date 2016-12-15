//
// Created by yaobanglin on 15/9/18.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^AlertViewCompleteBlock) (NSInteger buttonIndex);
/**
 * UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您还没有登录，马上登录?"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"马上登录", nil];
            [alert showWithCompleteBlock:^(NSInteger buttonIndex) {

            }];
 */
@interface UIAlertView (Block)
- (void)showWithCompleteBlock:(AlertViewCompleteBlock) block;
@end