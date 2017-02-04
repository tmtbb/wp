//
//  OEZHScrollView.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/25.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZViewCell.h"
/**
 *  横行滚动viewcell
 */
@interface OEZHScrollViewCell : OEZViewCell
@property (nonatomic,retain) UIColor *selectBackgroundColor;
@end

@class OEZHScrollView;
/**
 *  横向滚动view代理
 */
@protocol OEZHScrollViewDelegate <NSObject,UIScrollViewDelegate>
@required
/**
 *  获取cell总数
 *
 *  @param hScrollView hScrollView
 *
 *  @return cell总数
 */
-(NSInteger) numberColumnCountHScrollView:(OEZHScrollView*) hScrollView;
/**
 *  获取cell宽度
 *
 *  @param hScrollView hScrollView
 *  @param columnIndex cell索引
 *
 *  @return cell宽度
 */
-(CGFloat)   hScrollView:(OEZHScrollView *)hScrollView  widthForColumnAtIndex:(NSInteger)columnIndex;
/**
 *  获取viewcell
 *
 *  @param hScrollView hScrollView
 *  @param columnIndex cell索引
 *
 *  @return viewcell
 */
-(OEZHScrollViewCell*)   hScrollView:(OEZHScrollView*) hScrollView cellForColumnAtIndex:(NSInteger) columnIndex;
@optional
/**
 *  选中一个cell事件
 *
 *  @param pageView    hScrollView
 *  @param columnIndex cell索引
 */
-(void )     hScrollView:(OEZHScrollView*) hScrollView didSelectColumnAtIndex:(NSInteger) columnIndex;
@end
/**
 *  横向滚动view
 */
@interface OEZHScrollView : UIScrollView
/**
 *  选中背景色
 */
@property (nonatomic,retain) UIColor *selectBackgroundColor;
/**
 *  创建cell
 *
 *  @param identifier cell的identifier
 *
 *  @return 返回cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
/**
 *  注册 xib cell
 *
 *  @param nib        xib创建的UINib
 *  @param identifier cell的identifier
 */
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
/**
 *  注册 Class cell
 *
 *  @param cellClass  注册的cell 类
 *  @param identifier cell的identifier
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
/**
 *  重新加载数据
 */
- (void) reloadData;
@end
