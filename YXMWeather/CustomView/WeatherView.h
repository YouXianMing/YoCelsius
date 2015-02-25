//
//  WeatherView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/23.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherData.h"
#import "CurrentConditions.h"

@interface WeatherView : UIView

/**
 *  天气的数据
 */
@property (nonatomic, strong) CurrentWeatherData  *weahterData;
@property (nonatomic, strong) CurrentConditions   *weatherConditions;

/**
 *  显示动画
 */
- (void)show;

/**
 *  隐藏动画
 */
- (void)hide;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  进入loading状态
 */
- (void)intoLoadingStatus;

/**
 * 进入刷新状态
 */
- (void)intoUpdateStatus;

@end
