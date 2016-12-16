//
// Created by yaowang on 16/3/4.
// Copyright (c) 2016 180. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OEZModel : NSObject
/**
 *  属性名与json映射字典
 *
 *  @return
 */
+ (NSDictionary *) jsonKeysByPropertyKey;
/**
 *  排除填充属性名字典
 *
 *  @return
 */
+ (NSArray*) debarsByPropertyKey;
/**
 *  字段统一后缀
 *
 *  @return
 */
+ (NSString*)jsonKeyPostfix:(NSString*) name;
/**
 *  数组属性model class
 */
//+ (Class) arrayModleClass;
@end