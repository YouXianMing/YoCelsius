//
//  HumidityView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/18.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "HumidityView.h"
#import "CircleView.h"
#import "RotatedAngleView.h"
#import "HumidityCountLabel.h"

#define  CIRCLE_FRAME  CGRectMake(0, 0, 90, 90)
#define  TITLE_MOVE    10.f

@interface HumidityView ()

@property (nonatomic, strong) CircleView         *fullCircle;
@property (nonatomic, strong) CircleView         *showCircle;
@property (nonatomic, strong) RotatedAngleView   *rotateView;
@property (nonatomic, strong) HumidityCountLabel *countLabel;


@property (nonatomic, strong) UIImageView        *iconView;
@property (nonatomic, strong) UILabel            *titleLabel;

@end

@implementation HumidityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)buildView {
    CGRect circleRect = CIRCLE_FRAME;
    CGRect rotateRect = CGRectMake(0, 0, circleRect.size.width, circleRect.size.height);
    
    // 完整的圆
    self.fullCircle = [CircleView createDefaultViewWithFrame:circleRect];
    self.fullCircle.lineColor = COLOR_CIRCLE_;
    [self.fullCircle buildView];
    
    // 局部显示的圆
    self.showCircle = [CircleView createDefaultViewWithFrame:circleRect];
    [self.showCircle buildView];
    
    // 旋转的圆
    self.rotateView = [[RotatedAngleView alloc] initWithFrame:rotateRect];
    [self.rotateView addSubview:self.fullCircle];
    [self.rotateView addSubview:self.showCircle];
    [self addSubview:self.rotateView];
    
    // 计数的数据
    self.countLabel = [[HumidityCountLabel alloc] initWithFrame:rotateRect];
    [self addSubview:self.countLabel];
    
    /* ------------------------------- 静态view ------------------------------- */
    // 图标
    self.iconView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Humidity"]];
    self.iconView.center = CGPointMake(circleRect.size.height,
                                       circleRect.size.width / 2.f);
    self.iconView.alpha = 0.f;
    self.iconView.y    -= 10;
    self.iconView.x    -= 5;
    [self addSubview:self.iconView];
    
    // 文本
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.titleLabel.text          = @"Humidity";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = [UIFont fontWithName:LATO_BOLD size:LATO_14];
    self.titleLabel.width         = CIRCLE_FRAME.size.width;
    self.titleLabel.height        = 20.f;
    self.titleLabel.y             = CIRCLE_FRAME.size.height + 4;
    self.titleLabel.x            -= TITLE_MOVE;
    self.titleLabel.alpha         = 0.f;
    [self addSubview:self.titleLabel];
}

- (void)show {
    CGFloat circleFullPercent = 0.75;
    CGFloat duration          = 1.5;
    
    // 进行参数复位
    [self.fullCircle strokeEnd:0 animated:NO duration:0];
    [self.showCircle strokeEnd:0 animated:NO duration:0];
    [self.fullCircle strokeStart:0 animated:NO duration:0];
    [self.showCircle strokeStart:0 animated:NO duration:0];
    [self.rotateView roateAngle:0];
    
    // 设置动画
    [self.fullCircle strokeEnd:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeEnd:circleFullPercent * self.percent animated:YES duration:duration];
    [self.rotateView roateAngle:45.f duration:duration];
    self.countLabel.toValue = self.percent * 100;
    [self.countLabel showDuration:duration];
    
    /* ------------------------------- 静态view ------------------------------- */
    // 图标动画
    [UIView animateWithDuration:duration animations:^{
        self.iconView.alpha = 1.f;
        self.iconView.y    += 10;
        
        self.titleLabel.x    += TITLE_MOVE;
        self.titleLabel.alpha = 1.f;
    }];
}
- (void)hide {
    CGFloat duration = 0.75;
    
    CGFloat circleFullPercent = 0.75;
    
    [self.fullCircle strokeStart:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeStart:self.percent * circleFullPercent animated:YES duration:duration];
    [self.rotateView roateAngle:90.f duration:duration];
    [self.countLabel hideDuration:duration];
    
    /* ------------------------------- 静态view ------------------------------- */
    // 图标动画
    [UIView animateWithDuration:duration animations:^{
        self.iconView.alpha = 0.f;
        self.iconView.y    += 10;
        
        self.titleLabel.x    += TITLE_MOVE;
        self.titleLabel.alpha = 0.f;
    } completion:^(BOOL finished) {
        // 恢复初始值
        CGRect circleRect = CIRCLE_FRAME;
        self.iconView.center = CGPointMake(circleRect.size.height,
                                           circleRect.size.width / 2.f);
        self.iconView.alpha = 0.f;
        self.iconView.y -= 10;
        self.iconView.x -= 5;
        
        
        self.titleLabel.width         = CIRCLE_FRAME.size.width;
        self.titleLabel.height        = 20.f;
        self.titleLabel.y             = CIRCLE_FRAME.size.height + 4;
        self.titleLabel.x            -= TITLE_MOVE * 2;
        self.titleLabel.alpha         = 0.f;
    }];
}

@end
