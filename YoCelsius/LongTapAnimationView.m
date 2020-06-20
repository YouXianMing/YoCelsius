//
//  LongTapAnimationView.m
//  YouXianMingClock
//
//  Created by YouXianMing on 14-10-13.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "LongTapAnimationView.h"
#import "POP.h"

@interface LongTapAnimationView ()<POPAnimationDelegate>

@property (nonatomic, strong) UIButton  *button;

@end

@implementation LongTapAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 完整显示按住按钮后的动画效果
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:_button];
        
        // 按住按钮后没有松手的动画
        [_button addTarget:self
                    action:@selector(scaleToSmall)
          forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        
        // 按住按钮松手后的动画
        [_button addTarget:self
                    action:@selector(scaleAnimations)
          forControlEvents:UIControlEventTouchUpInside];
        
        // 按住按钮后拖拽出去的动画
        [_button addTarget:self
                    action:@selector(scaleToDefault)
          forControlEvents:UIControlEventTouchDragExit];
        
        // 默认关闭用户交互
        _button.userInteractionEnabled = NO;
    }
    
    return self;
}

/**
 *  在设定frame值的时候也设置button的frame值
 *
 *  @param frame 当前view的frame值
 */
- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    _button.bounds = frame;
}

- (void)scaleToSmall {
    
    CGFloat tmpScale = (_scaleValue > 0)? _scaleValue : 0.7f;
    
    // 变小尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(tmpScale, tmpScale)];
    scaleAnimation.delegate           = self; // 核心
    scaleAnimation.duration           = 0.30f;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    if (_countDown == 0) {
        
        [self performSelector:@selector(performSelectorEvent:)
                   withObject:@(0)
                   afterDelay:0.30 + 0.01];
        
    } else {
        
        for (int i = 0; i < _countDown; i++) {
            
            [self performSelector:@selector(performSelectorEvent:)
                       withObject:@(_countDown - 1 - i)
                       afterDelay:i + 1];
        }
    }
    
}

- (void)scaleToDefault {
    
    // 恢复尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.delegate           = self; // 核心
    scaleAnimation.duration           = 0.3;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    if (_countDown == 0) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
    } else {
        
        for (int i = 0; i < _countDown; i++) {
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }
    }
}

- (void)scaleAnimations {
    
    // 恢复尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.delegate           = self; // 核心
    scaleAnimation.duration           = 0.3;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    if (_countDown == 0) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
    } else {
        
        for (int i = 0; i < _countDown; i++) {
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }
    }
}

- (void)performSelectorEvent:(id)sender {
    
    if (_delegate) {
        
        [_delegate longPressCompleteWithView:self intNumber:sender];
    }
}

/**
 *  POP动画代理
 *
 *  @param anim 执行动画的那个对象
 */
- (void)pop_animationDidApply:(POPAnimation *)anim {
    
    NSValue *toValue = (NSValue *)[anim valueForKeyPath:@"currentValue"];
    CGSize size      = [toValue CGSizeValue];
    CGFloat tmpScale = (_scaleValue > 0)? _scaleValue : 0.7f;
    _percent         = (size.height - calculateConstant(0, 1, 1, tmpScale))/calculateSlope(0, 1, 1, tmpScale);
    
    if (_delegate) {
        
        [_delegate longPressPercentage:_percent view:self];
    }
}

CGFloat calculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

- (void)addSubview:(UIView *)view {
    
    [super addSubview:view];
    
    /**
     *  如果继承了这个类，则子类不会执行以下方法
     */
    if ([self class] == [LongTapAnimationView class]) {
        [self bringSubviewToFront:_button];
    }
}

- (void)activateButtonEffect {
    
    [self bringSubviewToFront:_button];
}

#pragma mark - 重写setter，getter方法
@synthesize canTouch = _canTouch;

- (void)setCanTouch:(BOOL)canTouch {
    
    _canTouch                      = canTouch;
    _button.userInteractionEnabled = canTouch;
}

- (BOOL)canTouch {
    
    return _canTouch;
}

@end
