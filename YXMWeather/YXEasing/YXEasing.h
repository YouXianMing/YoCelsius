//
//  YXEasing.h
//  Prize
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Easing.h"

/*---------------------------------------------

 -动画简单的解析-
 
 BackEase        ：在某一动画开始沿指示的路径进行动画处理前稍稍收回该动画的移动。
 BounceEase      ：创建弹跳效果。
 CircleEase      ：创建使用循环函数加速和/或减速的动画。
 CubicEase       ：创建使用公式 f(t) = t^3 加速和/或减速的动画。
 ElasticEase     ：创建类似于弹簧在停止前来回振荡的动画。
 ExponentialEase ：创建使用指数公式加速和/或减速的动画。
 PowerEase       ：创建使用公式 f(t) = t^p（其中，p 等于 Power 属性）加速和/或减速的动画。
 QuadraticEase   ：创建使用公式 f(t) = t^2 加速和/或减速的动画。
 QuarticEase     ：创建使用公式 f(t) = t^4 加速和/或减速的动画。
 QuinticEase     ：创建使用公式 f(t) = t^5 加速和/或减速的动画。
 SineEase        ：创建使用正弦公式加速和/或减速的动画。
 
LinearInterpolation

QuadraticEaseIn
QuadraticEaseOut
QuadraticEaseInOut

CubicEaseIn
CubicEaseOut
CubicEaseInOut

QuarticEaseIn
QuarticEaseOut
QuarticEaseInOut

QuinticEaseIn
QuinticEaseOut
QuinticEaseInOut

SineEaseIn
SineEaseOut
SineEaseInOut

CircularEaseIn
CircularEaseOut
CircularEaseInOut

ExponentialEaseIn
ExponentialEaseOut
ExponentialEaseInOut

ElasticEaseIn
ElasticEaseOut
ElasticEaseInOut

BackEaseIn
BackEaseOut
BackEaseInOut

BounceEaseIn
BounceEaseOut
BounceEaseInOut
---------------------------------------------*/

/*
 // 计算好起始值,结束值
 CGFloat oldValue = 0.f;
 CGFloat newValue = 1.f;
 
 // 关键帧动画
 CAKeyframeAnimation *animation = \
 [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
 
 // 设置值
 [animation setValues:[YXEasing calculateFrameFromValue:oldValue
 toValue:newValue
 func:ElasticEaseOut
 frameCount:500]];
 
 // 设置持续时间
 animation.duration  = 0.5f;
 
 // 每秒增加的角度(设定结果值,在提交动画之前执行)
 layer.transform = \
 CATransform3DMakeRotation(newValue, 0.0, 0.0, 1.0);
 
 // 提交动画
 [layer addAnimation:animation forKey:nil];
 
 */

@interface YXEasing : NSObject

// 数组中存储的数据为 NSNumber float 型
+ (NSArray *)calculateFrameFromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount;

// 数组中存储的数据为 NSValue CGPoint 型
+ (NSArray *)calculateFrameFromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount;

// 数组中存储的数据为 NSValue CGSize 型
+ (NSArray *)calculateFrameFromSize:(CGSize)fromSize
                             toSize:(CGSize)toSize
                               func:(AHEasingFunction)func
                         frameCount:(size_t)frameCount;

@end
