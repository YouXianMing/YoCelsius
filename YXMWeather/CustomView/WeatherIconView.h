//
//  WeatherIconView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/24.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    E_SUN, // 晴朗
} EWeatherIcon;

@interface WeatherIconView : UIView

/**
 *  天气信息
 */
@property (nonatomic) EWeatherIcon  weatherType;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
