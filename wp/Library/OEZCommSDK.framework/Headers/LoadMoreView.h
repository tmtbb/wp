//
//  LoadMoreView.h
//  douniwan
//
//  Created by 180 on 15/4/7.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZNibView.h"
/**
* 通用加载更多view
*/
@interface LoadMoreView : OEZNibView
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak,nonatomic) IBOutlet UILabel *loadLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelCenterX;

-(void) startLoadMore;
- (void)endLoadMoreNoText;
-(void) endLoadMore;
-(void) errorLoadMore;
-(void) notMore;
@end
