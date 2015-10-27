//
//  UIView+GlowView.h
//  YouXianClock
//
//  Created by YouXianMing on 14-10-15.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GlowView)

@property (nonatomic, strong) NSNumber *GCDTimerInterval; // 定时器的时间间隔，给float值
@property (nonatomic, strong) NSNumber *glowDuration;     // layer动画的时间长度，给float值
@property (nonatomic, strong) NSNumber *glowLayerOpacity; // 设置glowLayer的动画透明度的程度，给float值，范围在[0,1]

- (void)createGlowLayerWithColor:(UIColor *)color glowRadius:(CGFloat)radius;
- (void)startGlow;
- (void)glowToGlowLayerOnce;
- (void)glowToNormalLayerOnce;

@end
