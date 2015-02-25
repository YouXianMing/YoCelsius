//
//  RotatedAngleView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/18.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotatedAngleView : UIView

/**
 *  旋转角度与持续时间
 *
 *  @param angle    旋转角度
 *  @param duration 持续时间
 */
- (void)roateAngle:(CGFloat)angle duration:(CGFloat)duration;

/**
 *  旋转角度
 *
 *  @param angle 旋转角度
 */
- (void)roateAngle:(CGFloat)angle;

/**
 *  恢复动画效果
 *
 *  @param duration 恢复的时间
 */
- (void)recoverDuration:(CGFloat)duration;


@end
