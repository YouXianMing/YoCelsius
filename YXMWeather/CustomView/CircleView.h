//
//  CircleView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/17.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

/**
 *  线条宽度
 */
@property (nonatomic)         CGFloat   lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  旋转方向
 */
@property (nonatomic)         BOOL      clockWise;

/**
 *  开始角度
 */
@property (nonatomic)         CGFloat   startAngle;

/**
 *  初始化view
 */
- (void)buildView;

/**
 *  做stroke动画
 *
 *  @param value    取值 [0, 1]
 *  @param animated 时候执行动画
 */
- (void)strokeEnd:(CGFloat)value animated:(BOOL)animated duration:(CGFloat)duration;

@end
