//
//  UIView+GlowView.m
//  YouXianClock
//
//  Created by YouXianMing on 14-10-15.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+GlowView.h"
#import <objc/runtime.h>

#define GLOWVIEW_LAYER_FLAG     @"UIView+GlowView"

@interface UIView ()

@property (strong, nonatomic) dispatch_source_t  dispatchSource;
@property (strong, nonatomic) NSNumber          *glowViewShowFlag;

@end

@implementation UIView (GlowView)

#pragma mark - 动态添加了属性
static char dispatchSourceTimerFlag;

- (void)setDispatchSource:(dispatch_source_t)dispatchSource {
    
    objc_setAssociatedObject(self, &dispatchSourceTimerFlag, dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)dispatchSource {
    
    return objc_getAssociatedObject(self, &dispatchSourceTimerFlag);
}

static char charGlowViewShowFlag;

- (void)setGlowViewShowFlag:(NSNumber *)glowViewShowFlag {
    
    objc_setAssociatedObject(self, &charGlowViewShowFlag, glowViewShowFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowViewShowFlag {
    
    return objc_getAssociatedObject(self, &charGlowViewShowFlag);
}

static char GCDTimerIntervalFlag;

- (void)setGCDTimerInterval:(NSNumber *)GCDTimerInterval {
    
    objc_setAssociatedObject(self, &GCDTimerIntervalFlag, GCDTimerInterval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)GCDTimerInterval {
    
    return objc_getAssociatedObject(self, &GCDTimerIntervalFlag);
}

static char glowLayerOpacityFlag;

- (void)setGlowLayerOpacity:(NSNumber *)glowLayerOpacity {
    
    objc_setAssociatedObject(self, &glowLayerOpacityFlag, glowLayerOpacity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowLayerOpacity {
    
    return objc_getAssociatedObject(self, &glowLayerOpacityFlag);
}

static char glowDurationFlag;

- (void)setGlowDuration:(NSNumber *)glowDuration {
    
    objc_setAssociatedObject(self, &glowDurationFlag, glowDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowDuration {
    
    return objc_getAssociatedObject(self, &glowDurationFlag);
}

#pragma mark - 方法
- (void)createGlowLayerWithColor:(UIColor *)color glowRadius:(CGFloat)radius {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath* path = \
    [UIBezierPath bezierPathWithRect:(CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, self.bounds.size.height)}];
    [color setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    
    CALayer *glowLayer      = [CALayer layer];
    glowLayer.name          = GLOWVIEW_LAYER_FLAG;
    glowLayer.frame         = self.bounds;
    glowLayer.contents      = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    glowLayer.shadowOpacity = 1.0f;
    glowLayer.shadowOffset  = CGSizeMake(0, 0);
    glowLayer.shadowColor   = (color == nil ? [UIColor redColor].CGColor : color.CGColor);
    glowLayer.shadowRadius  = (radius > 0 ? radius : 2.f);
    glowLayer.opacity       = 0.f; // 开始时候的透明度为0
    [self.layer addSublayer:glowLayer];

    UIGraphicsEndImageContext();
}

- (void)startGlow {
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer *layer = obj;
        
        // 找到了layer才进行下面的操作
        if ([layer.name isEqualToString:GLOWVIEW_LAYER_FLAG]) {
            
            if (self.glowViewShowFlag == nil) {
                
                self.glowViewShowFlag = [NSNumber numberWithBool:NO];
            }
            
            if (self.dispatchSource == nil) {
                
                self.dispatchSource = \
                dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
                dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0),
                                          NSEC_PER_SEC * (self.GCDTimerInterval == nil ? 1 : self.GCDTimerInterval.floatValue), 0);
                dispatch_source_set_event_handler(self.dispatchSource, ^{
                    
                    if (self.glowViewShowFlag.boolValue == NO) {
                        
                        self.glowViewShowFlag = @(YES);
                        
                        // 做动画，从透明到显示出来
                        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                        
                        if (self.glowLayerOpacity != nil) {
                            
                            animation.fromValue = @(0.f);
                            animation.toValue   = [NSNumber numberWithFloat:self.glowLayerOpacity.floatValue];
                            layer.opacity       = self.glowLayerOpacity.floatValue;
                            
                        } else {
                            
                            animation.fromValue = @(0.f);
                            animation.toValue   = @(0.8f);
                            layer.opacity       = 0.8;
                            
                        }
                        
                        if (self.glowDuration != nil) {
                            
                            animation.duration = self.glowDuration.floatValue;
                            
                        } else {
                            
                            animation.duration = 0.8;
                        }
                        
                        [layer addAnimation:animation forKey:nil];
                        
                    } else {
                        
                        self.glowViewShowFlag = @(NO);
                        
                        // 做动画
                        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                        animation.fromValue         = [NSNumber numberWithFloat:layer.opacity];
                        animation.toValue           = @(0.f);
                        
                        if (self.glowDuration != nil) {
                            
                            animation.duration = self.glowDuration.floatValue;
                            layer.opacity      = 0.f;
                            
                        } else {
                            
                            animation.duration = 0.8;
                            layer.opacity      = 0.f;
                        }
                        
                        [layer addAnimation:animation forKey:nil];
                    }
                });
                
                dispatch_resume(self.dispatchSource);
            }
        }
    }];
}

- (void)glowToGlowLayerOnce {
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer *layer = obj;
        
        // 找到了layer才进行下面的操作
        if ([layer.name isEqualToString:GLOWVIEW_LAYER_FLAG]) {
            
                // 做动画，从透明到显示出来
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                if (self.glowLayerOpacity != nil) {
                    
                    animation.fromValue = @(0.f);
                    animation.toValue   = [NSNumber numberWithFloat:self.glowLayerOpacity.floatValue];
                    layer.opacity       = self.glowLayerOpacity.floatValue;
                    
                } else {
                    
                    animation.fromValue = @(0.f);
                    animation.toValue   = @(0.8f);
                    layer.opacity       = 0.8;
                }
                
                if (self.glowDuration != nil) {
                    
                    animation.duration = self.glowDuration.floatValue;
                    
                } else {
                    
                    animation.duration = 0.8;
                }
            
                [layer addAnimation:animation forKey:nil];
        }
    }];
}

- (void)glowToNormalLayerOnce {
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CALayer *layer = obj;
        
        // 做动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue         = [NSNumber numberWithFloat:layer.opacity];
        animation.toValue           = @(0.f);
        
        if (self.glowDuration != nil) {
            
            animation.duration = self.glowDuration.floatValue;
            layer.opacity      = 0.f;
            
        } else {
            
            animation.duration = 0.8;
            layer.opacity      = 0.f;
        }
        
        [layer addAnimation:animation forKey:nil];
    }];
}

@end
