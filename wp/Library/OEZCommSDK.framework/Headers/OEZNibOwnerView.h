//
//  OEZXibView.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/23.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZBaseView.h"
/**
 *  可以在storyboard用的自定义类
 * 注意xib文件的File's Owner为当前类名,而不是直接view为当前类名
 */
@interface OEZNibOwnerView : OEZBaseView
@property (readonly) UIView* contentView;
+ (instancetype) loadFromNib;
-(NSString*) nibOwnerName;
@end
