//
//  OEZPListModelAdapter.h
//  magicbeanTest
//
//  Created by yaowang on 16/3/5.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OEZModel.h"
@interface OEZPListModelAdapter : NSObject
/**
 *  加载plist文件为model
 *
 *  @param modelClass modelClass
 *  @param plistPath  <#plistPath description#>
 *  @param error      <#error description#>
 *
 *  @return <#return value description#>
 */
+ (id) modelOfClass:(Class)modelClass plistPath:(NSString *)plistPath error:(NSError **)error;
/**
 *  加载plist为model数组
 *
 *  @param modelClass <#modelClass description#>
 *  @param plistPath  <#plistPath description#>
 *  @param error      <#error description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *) modelsOfClass:(Class)modelClass plistPath:(NSString *)plistPath error:(NSError **)error;
/**
 *  model保存为plist文件
 *
 *  @param model     <#model description#>
 *  @param plistPath <#plistPath description#>
 *  @param error     <#error description#>
 */
+ (void) plistFileFormModel:(OEZModel*) model  plistPath:(NSString *)plistPath error:(NSError **)error;
/**
 *  model数组保存为plist文件
 *
 *  @param models    <#models description#>
 *  @param plistPath <#plistPath description#>
 *  @param error     <#error description#>
 */
+ (void) plistFileFormModels:(NSArray *) models  plistPath:(NSString *)plistPath error:(NSError **)error;
@end
