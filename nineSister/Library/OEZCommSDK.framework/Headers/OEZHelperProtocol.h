//
//  HelperProtocol.h
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//
#import <Foundation/Foundation.h>
#define HELPER_SHARED(CLASS) +(instancetype)shared{ \
static CLASS *sharedHelper = nil;\
static dispatch_once_t predicate;\
dispatch_once(&predicate, ^{\
sharedHelper = [[CLASS alloc] init];\
});\
return sharedHelper;}

/**
 * 单例统一接口协议
 */
@protocol OEZHelperProtocol <NSObject>
+(instancetype)shared;
@end