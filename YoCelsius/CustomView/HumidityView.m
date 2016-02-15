//
//  HumidityView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "HumidityView.h"
#import "CircleView.h"
#import "RotatedAngleView.h"
#import "HumidityCountLabel.h"
#import "TitleMoveLabel.h"

@interface HumidityView ()

@property (nonatomic, strong) CircleView         *fullCircle;
@property (nonatomic, strong) CircleView         *showCircle;
@property (nonatomic, strong) RotatedAngleView   *rotateView;
@property (nonatomic, strong) HumidityCountLabel *countLabel;

@property (nonatomic, strong) TitleMoveLabel     *titleMoveLabel;

@end

@implementation HumidityView

- (void)buildView {
    
    CGRect circleRect = CGRectZero;
    CGRect rotateRect = CGRectZero;
    
    if (iPhone5_5s || iPhone4_4s) {
        
        circleRect = CGRectMake(0, 0, 100, 100);
        rotateRect = CGRectMake(37, 40, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6s) {
        
        circleRect = CGRectMake(0, 0, 110, 110);
        rotateRect = CGRectMake(40, 50, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6sPlus) {
        
        circleRect = CGRectMake(0, 0, 115, 115);
        rotateRect = CGRectMake(45, 55, circleRect.size.width, circleRect.size.height);
        
    } else {
        
        circleRect = CGRectMake(0, 0, 90, 90);
        rotateRect = CGRectMake(25, 15, circleRect.size.width, circleRect.size.height);
    }
        
    // 移动的头部位
    self.titleMoveLabel = [TitleMoveLabel withText:@"Humidity"];
    [self addSubview:self.titleMoveLabel];
    
    // 完整的圆
    self.fullCircle           = [CircleView createDefaultViewWithFrame:circleRect];
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
    self.countLabel.backgroundColor = [UIColor clearColor];
    self.countLabel.x += 4;
    [self addSubview:self.countLabel];
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
    
    // 标题显示
    [self.titleMoveLabel show];
    
    // 设置动画
    [self.fullCircle strokeEnd:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeEnd:circleFullPercent * self.percent animated:YES duration:duration];
    [self.rotateView roateAngle:45.f duration:duration];
    self.countLabel.toValue = self.percent * 100;
    [self.countLabel showDuration:duration];
}

- (void)hide {
    
    CGFloat duration          = 0.75;
    CGFloat circleFullPercent = 0.75;
    
    // 标题隐藏
    [self.titleMoveLabel hide];
    
    [self.fullCircle strokeStart:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeStart:self.percent * circleFullPercent animated:YES duration:duration];
    [self.rotateView roateAngle:90.f duration:duration];
    [self.countLabel hideDuration:duration];
}

@end
