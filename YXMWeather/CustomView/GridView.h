//
//  GridView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView

/**
 *  坐标点
 */
@property (nonatomic) CGPoint origin;

/**
 *  小格的宽度
 */
@property (nonatomic) CGFloat gridLength;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  显示时长
 *
 *  @param duration 时间长度
 */
- (void)showWithDuration:(CGFloat)duration;

/**
 *  隐藏时长
 *
 *  @param duration 时间长度
 */
- (void)hideWithDuration:(CGFloat)duration;

@end
