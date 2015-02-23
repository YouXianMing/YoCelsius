//
//  LoadingView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/23.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
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
