//
//  PageView.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/22.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OEZViewCell.h"
/**
 *  分页view的Cell
 */
@interface OEZPageViewCell : OEZViewCell
@end
/**
 *  默认的分页的image cell
 */
@interface OEZPageViewImageCell : OEZPageViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@end


@class OEZPageView;
/**
 *  分页view代理
 */
@protocol OEZPageViewDelegate <NSObject/*,UIScrollViewDelegate*/>
@required
/**
 *  获取分页总数
 *
 *  @param pageView OEZPageView
 *
 *  @return 分页总数
 */
-(NSInteger) numberPageCountPageView:(OEZPageView*) pageView;
/**
 *  获取cell
 *
 *  @param pageView  OEZPageView
 *  @param pageIndex 第几页索引
 *
 *  @return cell
 */
-(OEZPageViewCell*)   pageView:(OEZPageView*) pageView cellForPageAtIndex:(NSInteger) pageIndex;
@optional
/**
 *  选中一个cell
 *
 *  @param pageView  OEZPageView
 *  @param pageIndex 选中的第几个的索引
 */
-(void )     pageView:(OEZPageView*) pageView didSelectPageAtIndex:(NSInteger) pageIndex;
/**
 *  显示第几个cell
 *
 *  @param pageView  OEZPageView
 *  @param pageIndex 显示第几个cell的索引
 */
-(void )     pageView:(OEZPageView*) pageView didShowPageAtIndex:(NSInteger) pageIndex;
@end
/**
 *  分页自定义控件
 */
@interface OEZPageView : UIView<UIScrollViewDelegate>
@property (readonly) UIScrollView*  scrollView;
@property (readonly) UIPageControl* pageControl;
@property(nonatomic,weak) id<OEZPageViewDelegate>     delegate;
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
- (void)reloadData;
/**
 *  设置显示第几个cell
 *
 *  @param pageIndex 显示的cell索引
 */
-(void) setPageIndex:(NSInteger) pageIndex;
/**
 *  <#Description#>
 *
 *  @param pageIndex <#pageIndex description#>
 *
 *  @return <#return value description#>
 */
-(OEZPageViewCell*) cellForRowAtIndex:(NSInteger) pageIndex;
@end
