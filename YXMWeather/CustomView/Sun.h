//
//  Sun.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sun : UIView

@property (nonatomic) CGRect upCenterRect;   
@property (nonatomic) CGRect downCenterRect;

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

@end
