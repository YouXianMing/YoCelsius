//
//  WindSpeedView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/19.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindSpeedView : UIView

/**
 *  一秒钟旋转几圈
 */
@property (nonatomic) CGFloat circleByOneSecond;

/**
 *  风的速度
 */
@property (nonatomic) CGFloat windSpeed;

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
