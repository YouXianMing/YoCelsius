//
//  SunsetView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "Sun.h"

@interface SunsetView : Sun

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)showWithDuration:(CGFloat)duration;

/**
 *  隐藏动画
 *
 *  @param duration 动画时间
 */
- (void)hideWithDuration:(CGFloat)duration;

/**
 *  创建出view(先初始化出view,然后再传图片)
 */
- (void)buildView;

@end
