//
// Created by 180 on 15/1/16.
// Copyright (c) 2015 180. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OEZHelperProtocol.h"

@protocol OEZHandleOpenURLDelegate<NSObject>
- (BOOL) handleOpenURL:(NSURL *)url ;
- (NSString*) getKey;
@end
/**
 *  统一化管理app handleOpenURL
 */
@interface OEZHandleOpenURLHelper : NSObject<OEZHelperProtocol>
/**
 *  AppDelegate 中handleOpenURL 调用这个handleOpenURL
 *
 *  @param url open url
 *
 *  @return bool
 */
-(BOOL) handleOpenURL:(NSURL *)url ;
/**
 *  增加HandleOpenURLDelegate
 *
 *  @param handle HandleOpenURLDelegate
 */
- (void) addHandleDelegate:(id<OEZHandleOpenURLDelegate>) handle;
/**
 *  移除HandleOpenURLDelegate
 *
 *  @param handle HandleOpenURLDelegate
 */
- (void) removeHandleDelegate:(id<OEZHandleOpenURLDelegate>) handle;
@end