//
//  WindSpeedView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/19.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WindSpeedView.h"
#import "ThreeLineView.h"
#import "WindSpeedCountLabel.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface WindSpeedView ()

@property (nonatomic, strong) ThreeLineView       *threeLineView;
@property (nonatomic, strong) UIView              *line;
@property (nonatomic, strong) CGRectStoreValue    *lineStoreValue;
@property (nonatomic, strong) UIView              *circleView;
@property (nonatomic, strong) TitleMoveLabel      *titleMoveLabel;
@property (nonatomic, strong) WindSpeedCountLabel *windCountLabel;
@property (nonatomic, strong) CGRectStoreValue    *windCountLabelStoreValue;

@end

@implementation WindSpeedView


- (void)buildView {
    
    CGFloat windOffsetX = 40;
    CGFloat windOffsetY = 40;
    CGRect windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
    
    if (iPhone4_4s || iPhone5_5s) {
        
        windOffsetX = 40;
        windOffsetY = 40;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
        
    } else if (iPhone6_6s) {
        
        windOffsetX = 40;
        windOffsetY = 50;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 65, 65);
        
    } else if (iPhone6_6sPlus) {
        
        windOffsetX = 40;
        windOffsetY = 55;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 70, 70);
        
    } else {
        
        windOffsetX = 40;
        windOffsetY = 40;
        windFrame = CGRectMake(windOffsetX, windOffsetY, 60, 60);
    }
    
    // 创建出扇叶
    self.threeLineView = [[ThreeLineView alloc] initWithFrame:windFrame];
    [self addSubview:self.threeLineView];
    
    // 移动的头部位
    self.titleMoveLabel = [TitleMoveLabel withText:@"Wind Speed"];
    [self addSubview:self.titleMoveLabel];
    
    
    // 创建出风速变化的标签
    if (iPhone4_4s || iPhone5_5s) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 120, 93, 15)];
        
    } else if (iPhone6_6s) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 143, 93, 15)];
        
    } else if (iPhone6_6sPlus) {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(45, 155, 93, 15)];
        
    } else {
        
        self.windCountLabel = [[WindSpeedCountLabel alloc] initWithFrame:CGRectMake(15, 90, 93, 15)];
    }
    
    [self addSubview:self.windCountLabel];
    self.windCountLabelStoreValue = [CGRectStoreValue new];
    self.windCountLabelStoreValue.midRect = self.windCountLabel.frame;
    self.windCountLabel.x += 10;
    self.windCountLabelStoreValue.startRect = self.windCountLabel.frame;
    self.windCountLabel.x -= 10;
    self.windCountLabel.y -= 10;
    self.windCountLabelStoreValue.endRect   = self.windCountLabel.frame;
    self.windCountLabel.frame = self.windCountLabelStoreValue.startRect;
    self.windCountLabel.alpha = 0.f;
    
    // 创建出支柱
    if (iPhone4_4s || iPhone5_5s) {
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 60.f)];
        
    } else if (iPhone6_6s) {
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 70.f)];
        
    } else if (iPhone6_6sPlus) {
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 75.f)];
        
    } else {
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.f, 60.f)];
    }
    
    [self addSubview:self.line];
    self.line.centerX = self.threeLineView.middleX;
    self.line.y       = windFrame.size.height / 2.f;
    self.line.x      += windOffsetX;
    self.line.y      += windOffsetY;
    self.line.backgroundColor = [UIColor blackColor];
    
    CGFloat gapFromCenter = 3.f;
    
    self.lineStoreValue = [CGRectStoreValue new];
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
    self.circleView.x += windOffsetX;
    self.circleView.y += windOffsetY;
    self.circleView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.circleView];
    self.circleView.alpha = 0.f;
}

- (void)show {
    
    CGFloat duration = 1.5;
    
    // 扇叶动画
    [self.threeLineView.layer removeAllAnimations];
    self.threeLineView.circleByOneSecond = self.circleByOneSecond; // 设置转速
    
    [GCDQueue executeInMainQueue:^{
        
        [self.threeLineView rotateImageViewWithCircleByOneSecond];
        
    } afterDelaySecs:0.01f];
    
    [self.threeLineView showWithDuration:duration animated:YES];
    
    // 标签数字动画
    self.windCountLabel.toValue = self.windSpeed;
    [self.windCountLabel showDuration:duration];
    
    // 标题
    [self.titleMoveLabel show];
    
    // 支柱动画 + 圆动画 + 文本动画 + 标签数字动画
    [UIView animateWithDuration:duration animations:^{
        
        self.line.alpha = 1.f;
        self.line.frame = self.lineStoreValue.midRect;
        
        self.circleView.alpha = 1.f;
        
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
    
    // 标题
    [self.titleMoveLabel hide];
    
    // 支柱动画 + 圆动画
    [UIView animateWithDuration:duration animations:^{
        
        self.line.alpha = 0.f;
        self.line.frame = self.lineStoreValue.endRect;
        
        self.circleView.alpha = 0.f;
        
        self.windCountLabel.frame = self.windCountLabelStoreValue.endRect;
        self.windCountLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.line.frame           = self.lineStoreValue.startRect;
        self.windCountLabel.frame = self.windCountLabelStoreValue.startRect;
    }];
}

@end
