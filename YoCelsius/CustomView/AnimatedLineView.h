//
//  AnimatedLineView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"

@interface AnimatedLineView : UIView

/**
 *  显示的图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 *  显示出来
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated;

/**
 *  隐藏
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated;

@end
