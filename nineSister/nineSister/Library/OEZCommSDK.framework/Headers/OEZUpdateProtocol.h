//
// Created by 180 on 15/4/10.
// Copyright (c) 2015 180. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OEZUpdateProtocol <NSObject>
/**
 *  统一化 update
 *
 *  @param data 数据
 */
-(void) update:(id) data;
@end

@protocol OEZCalculateProtocol <NSObject>

+(CGFloat) calculateHeightWithData:(id) data;

@end