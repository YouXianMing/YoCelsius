//
//  WindSpeedView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/19.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "WindSpeedView.h"
#import "ThreeLineView.h"
#import "WindSpeedCountLabel.h"


@interface LineStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation LineStoreValue
@end



@interface TilteLabelStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation TilteLabelStoreValue
@end


@interface WindSpeedCountLabelStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation WindSpeedCountLabelStoreValue
@end


@interface WindSpeedView ()

@property (nonatomic, strong) ThreeLineView   *threeLineView;


@property (nonatomic, strong) UIView          *line;
@property (nonatomic, strong) LineStoreValue  *lineStoreValue;


@property (nonatomic, strong) UIView          *circleView;


@property (nonatomic, strong) UILabel               *titleLabel;
@property (nonatomic, strong) TilteLabelStoreValue  *titleLabelStoreValue;


@property (nonatomic, strong) WindSpeedCountLabel            *windCountLabel;
@property (nonatomic, strong) WindSpeedCountLabelStoreValue  *windCountLabelStoreValue;


@end

@implementation WindSpeedView


- (void)buildView {
    CGRect windFrame = CGRectMake(0, 0, 70, 70);
    
    // 创建出扇叶
    self.threeLineView = [[ThreeLineView alloc] initWithFrame:windFrame];
    [self addSubview:self.threeLineView];
    
    
    // 创建出风速变化的标签
    self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(0, 87, 94, 15)];
    [self addSubview:self.windCountLabel];
    self.windCountLabelStoreValue = [WindSpeedCountLabelStoreValue new];
    self.windCountLabelStoreValue.midRect = self.windCountLabel.frame;
    self.windCountLabel.x += 10;
    self.windCountLabelStoreValue.startRect = self.windCountLabel.frame;
    self.windCountLabel.x -= 10;
    self.windCountLabel.y -= 10;
    self.windCountLabelStoreValue.endRect   = self.windCountLabel.frame;
    self.windCountLabel.frame = self.windCountLabelStoreValue.startRect;
    self.windCountLabel.alpha = 0.f;
    
    
    // 创建出支柱
    self.line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 60.f)];
    [self addSubview:self.line];
    self.line.centerX = self.threeLineView.middleX;
    self.line.y       = windFrame.size.height / 2.f;
    self.line.backgroundColor = [UIColor blackColor];
    
    CGFloat gapFromCenter = 5.f;
    
    self.lineStoreValue = [LineStoreValue new];
    CGRect startRect = CGRectMake(self.line.x,
                                  self.line.y + self.line.height + gapFromCenter * 2 * 2,
                                  self.line.width,
                                  0);
    CGRect midRect = CGRectMake(self.line.x,
                                self.line.y + gapFromCenter,
                                self.line.width,
                                self.line.height);
    CGRect endRect = CGRectMake(self.line.x,
                                self.line.y,
                                self.line.width,
                                0);
    self.lineStoreValue.startRect = startRect;
    self.lineStoreValue.midRect   = midRect;
    self.lineStoreValue.endRect   = endRect;
    self.line.frame               = startRect;
    
    // 创建出圆圈
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    self.circleView.center = self.threeLineView.middlePoint;
    self.circleView.layer.cornerRadius = self.circleView.height / 2.f;
    self.circleView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.circleView];
    self.circleView.alpha = 0.f;
    
    // 文本
    self.titleLabelStoreValue     = [TilteLabelStoreValue new];
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.titleLabel.text          = @"Wind Speed";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = [UIFont fontWithName:LATO_BOLD size:LATO_14];
    self.titleLabel.width         = 100;
    self.titleLabel.height        = 20.f;
    self.titleLabel.x            += 6.5f;
    self.titleLabel.y             = endRect.origin.y + 70;
    self.titleLabel.alpha = 0.f;
    
    // 文本 - 存储文本相关操作
    self.titleLabelStoreValue.midRect = self.titleLabel.frame;
    self.titleLabel.y += 10.f;
    self.titleLabelStoreValue.startRect = self.titleLabel.frame;
    self.titleLabel.y -= 20.f;
    self.titleLabelStoreValue.endRect = self.titleLabel.frame;
    self.titleLabel.frame = self.titleLabelStoreValue.startRect;

    
    [self addSubview:self.titleLabel];

}

- (void)show {
    CGFloat duration = 1.5;
    
    // 扇叶动画
    [self.threeLineView.layer removeAllAnimations];
    self.threeLineView.circleByOneSecond = self.circleByOneSecond; // 设置转速
    [self.threeLineView rotateImageViewWithCircleByOneSecond];
    [self.threeLineView showWithDuration:duration animated:YES];
    
    // 标签数字动画
    self.windCountLabel.toValue = self.windSpeed;
    [self.windCountLabel showDuration:duration];
    
    // 支柱动画 + 圆动画 + 文本动画 + 标签数字动画
    [UIView animateWithDuration:duration animations:^{
        self.line.alpha = 1.f;
        self.line.frame = self.lineStoreValue.midRect;
        
        self.circleView.alpha = 1.f;
        
        self.titleLabel.alpha = 1.f;
        self.titleLabel.frame = self.titleLabelStoreValue.midRect;
        
        
        self.windCountLabel.frame = self.windCountLabelStoreValue.midRect;
        self.windCountLabel.alpha = 1.f;
    }];
}

- (void)hide {
    CGFloat duration = 0.75;
    
    // 扇叶动画
    [self.threeLineView hideWithDuration:duration animated:YES];
    
    // 标签数字动画
    [self.windCountLabel hideDuration:duration];

    // 支柱动画 + 圆动画
    [UIView animateWithDuration:duration animations:^{
        self.line.alpha = 0.f;
        self.line.frame = self.lineStoreValue.endRect;
        
        self.circleView.alpha = 0.f;
        
        self.titleLabel.alpha = 0.f;
        self.titleLabel.frame = self.titleLabelStoreValue.endRect;
        
        self.windCountLabel.frame = self.windCountLabelStoreValue.endRect;
        self.windCountLabel.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.line.frame = self.lineStoreValue.startRect;
        
        self.titleLabel.frame = self.titleLabelStoreValue.startRect;
        
        self.windCountLabel.frame = self.windCountLabelStoreValue.startRect;
    }];
}

@end
