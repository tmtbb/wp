//
// Created by yaobanglin on 15/9/8.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OEZWeakMutableArray :NSObject
- (NSUInteger) count;
- (void) addObject:(id) object;
- (void) addSingletonObject:(id) object;
- (void) removeObject:(id) object;
- (void) removeObjectAtIndex:(NSUInteger) index;
- (void) enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block ;
- (void) enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
@end
@interface OEZSoftLockMutableArray: OEZWeakMutableArray
@end