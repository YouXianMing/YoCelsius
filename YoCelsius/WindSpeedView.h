//
//  WindSpeedView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/19.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
