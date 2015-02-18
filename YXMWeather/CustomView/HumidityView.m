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

@interface HumidityView ()

@property (nonatomic, strong) CircleView       *fullCircle;
@property (nonatomic, strong) CircleView       *showCircle;
@property (nonatomic, strong) RotatedAngleView *rotateView;

@end

@implementation HumidityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)buildView {
    CGRect circleRect = CGRectMake(0, 0, 67, 67);
    CGRect rotateRect = CGRectMake(10, 10, circleRect.size.width, circleRect.size.height);
    
    self.fullCircle = [CircleView createDefaultViewWithFrame:circleRect];
    self.fullCircle.lineColor = COLOR_CIRCLE_;
    [self.fullCircle buildView];
    
    self.showCircle = [CircleView createDefaultViewWithFrame:circleRect];
    [self.showCircle buildView];
    
    self.rotateView = [[RotatedAngleView alloc] initWithFrame:rotateRect];
    [self.rotateView addSubview:self.fullCircle];
    [self.rotateView addSubview:self.showCircle];
    [self addSubview:self.rotateView];
}

- (void)show {
    CGFloat circleFullPercent = 0.75;
    CGFloat duration          = 1.5;
    
    [self.fullCircle strokeEnd:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeEnd:circleFullPercent * self.percent animated:YES duration:duration];
    [self.rotateView roateAngle:20.f duration:duration];
}
- (void)hide {
    CGFloat duration = 0.75;
    
    [self.fullCircle strokeEnd:0 animated:YES duration:duration];
    [self.showCircle strokeEnd:0 animated:YES duration:duration];
    [self.rotateView recoverDuration:duration];
}

@end
