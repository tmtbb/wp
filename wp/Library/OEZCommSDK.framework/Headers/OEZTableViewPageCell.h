//
//  OEZTableViewPageCell.h
//  OEZCommSDK
//
//  Created by 180 on 15/1/24.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
/**
 *  默认的横向分页tableviewcell
 */
@interface OEZTableViewPageCell : OEZTableViewCell<OEZPageViewDelegate>
@property (nonatomic,readonly) OEZPageView *pageView;
@end
