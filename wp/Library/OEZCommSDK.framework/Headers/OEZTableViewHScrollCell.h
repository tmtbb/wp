//
//  OEZTableViewHScrollCell.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/26.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
/**
 *  默认的横向滚动tableviewcell
 */
@interface OEZTableViewHScrollCell : OEZTableViewCell<OEZHScrollViewDelegate>
@property (readonly) OEZHScrollView* hScrollView;
@end
