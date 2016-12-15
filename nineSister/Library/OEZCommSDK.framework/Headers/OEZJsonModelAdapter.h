//
// Created by yaowang on 16/3/4.
// Copyright (c) 2016 180. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OEZModel.h"
extern NSString * const OEZJsonModelAdapterErrorDomain;
extern NSInteger const OEZJsonModelAdapterErrorInvalidJSONDictionary;

@interface OEZJsonModelAdapter : NSObject
/**
 *  加载字典为model
 *
 *  @param modelClass     <#modelClass description#>
 *  @param JSONDictionary <#JSONDictionary description#>
 *  @param error          <#error description#>
 *
 *  @return <#return value description#>
 */
+ (id)modelOfClass:(Class)modelClass fromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;
/**
 *  加载字典数组为models
 *
 *  @param modelClass <#modelClass description#>
 *  @param JSONArray  <#JSONArray description#>
 *  @param error      <#error description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)modelsOfClass:(Class)modelClass fromJSONArray:(NSArray *)JSONArray error:(NSError **)error;
/**
 *  model转字典
 *
 *  @param model <#model description#>
 *  @param error <#error description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *) jsonDictionaryFromModel:(OEZModel*) model error:(NSError **)error;
/**
 *  models转字典数组
 *
 *  @param models <#models description#>
 *  @param error  <#error description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *) jsonArrayFromModels:(NSArray *) models error:(NSError **)error;
@end