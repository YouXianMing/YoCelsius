//
//  DismissingAnimator.m
//  MeiBaoShangCheng
//
//  Created by wooboo on 14-6-17.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "DismissingAnimator.h"
#import "UIView+SetRect.h"

@implementation DismissingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    // 自己的view
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    // 动画时间
    CGFloat duration = [self transitionDuration:transitionContext];
    
    // 开始点 + 结束点
    CGPoint startPoint = fromView.center;
    CGPoint endPoint   = CGPointMake(fromView.middleX,
                                     fromView.middleY + Height);
    
    // 关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath              = @"position";
    keyAnimation.values               = [YXEasing calculateFrameFromPoint:startPoint toPoint:endPoint
                                                                     func:CubicEaseIn frameCount:duration * 60.f];
    keyAnimation.duration             = duration;
    fromView.center                   = endPoint;
    [fromView.layer addAnimation:keyAnimation forKey:nil];
    
    [GCDQueue executeInMainQueue:^{
        
        [transitionContext completeTransition:YES];
        
    } afterDelaySecs:duration];
}

@end
