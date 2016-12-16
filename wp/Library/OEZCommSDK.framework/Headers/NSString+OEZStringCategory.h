//
//
//  Created by 180 on 14/9/21.
//  Copyright (c) 2014年 180. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OEZStringCategory)

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingDictNoEncode:(NSDictionary *)params;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict addingPercentEscapes:(BOOL)add;
- (NSDictionary *)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)urlEncoding;
- (NSString *)urlDecoding;

- (NSString *)trim;
- (BOOL)isEmpty;
+ (BOOL)isEmpty:(NSString*) str;
//- (BOOL)eq:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (NSString *)getterToSetter;
- (NSString *)setterToGetter;

- (NSString *)formatJSON;
+ (NSString *)guidString;
- (NSString *)removeHtmlTags;

- (BOOL)has4ByteChar;
- (BOOL)isAsciiString;
@end

@interface NSString (OEZStringEncryptionCategory)

- (NSString *)md5Hex;
- (NSData *)hexStringToData;    //从16进制的字符串格式转换为NSData

@end

