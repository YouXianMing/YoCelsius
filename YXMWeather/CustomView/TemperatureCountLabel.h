//
//  TemperatureCountLabel.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/22.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemperatureCount.h"

@interface TemperatureCountLabel : UIView

/**
 *  起始值
 */
@property (nonatomic) CGFloat fromValue;

/**
 *  结束值
 */
@property (nonatomic) CGFloat toValue;

/**
 *  动画引擎
 */
@property (nonatomic, strong) TemperatureCount  *temperatureCount;

/**
 *  显示用的label
 */
@property (nonatomic, strong) UILabel         *countLabel;

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)showDuration:(CGFloat)duration;

/**
 *  隐藏动画
 *
 *  @param duration 隐藏时间
 */
- (void)hideDuration:(CGFloat)duration;


@end
