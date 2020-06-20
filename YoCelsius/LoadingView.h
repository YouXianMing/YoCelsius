//
//  LoadingView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/**
 *  静态图片
 */
@property (nonatomic, strong) UIImage *staticCircleImage;

/**
 *  动画图片
 */
@property (nonatomic, strong) UIImage *animtedImage;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
