//
//  Created by 180 on 14/9/21.
//  Copyright (c) 2014年 180. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationController (OEZNavigationControllerCategory)
-(void) pushViewControllerWithIdentifier:(NSString *)identifier  animated:(BOOL)animated;
-(void) pushViewControllerWithIdentifier:(NSString *)identifier  animated:(BOOL)animated valuesForKeys:(NSDictionary*) valuesForKeys;
-(void) pushViewControllerWithIdentifier:(NSString *)identifier completion:(void (^)(UIViewController* viewController)) completion  animated:(BOOL)animated ;
@end