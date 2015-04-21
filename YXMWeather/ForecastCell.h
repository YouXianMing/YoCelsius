//
//  ForecastCell.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/26.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell

/**
 *  处理常规数据
 *
 *  @param data 处理的数据
 */
- (void)acccessData:(id)data indexPath:(NSIndexPath *)indexPath;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
