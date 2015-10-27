//
//  MaxTempCountLabel.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "MaxTempCount.h"

@interface MaxTempCountLabel : UIView

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
@property (nonatomic, strong) MaxTempCount   *maxTempCount;

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
