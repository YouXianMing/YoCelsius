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

@protocol WeatherViewDelegate <NSObject>
- (void)pullUpEventWithData:(CurrentConditions *)condition;
- (void)pullDownToRefreshData;
@end

@interface WeatherView : UIView


/**
 *  代理
 */
@property (nonatomic, weak)   id<WeatherViewDelegate> delegate;

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

@end
