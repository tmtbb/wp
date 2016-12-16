//
//  OEZView.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/24.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZBaseView.h"
/**
 *  直接nib文件创建view类
 */
@interface OEZNibView : OEZBaseView
/**
 *  加载nib文件
 *
 *  @param nibName nib文件名
 *
 *  @return 返回当前view
 */
+ (instancetype) loadFromNib:(NSString*) nibName;
/**
 *  以当前类名为nib文件名加载
 *
 *  @return 返回当前view
 */
+ (instancetype) loadFromNib;
@end
