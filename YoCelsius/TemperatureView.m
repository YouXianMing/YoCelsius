//
//  TemperatureView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "TemperatureView.h"
#import "TemperatureCountLabel.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface TemperatureView ()

@property (nonatomic, strong) TemperatureCountLabel  *countLabel;
@property (nonatomic, strong) CGRectStoreValue       *countLabelStoreValue;
@property (nonatomic, strong) TitleMoveLabel         *titleMoveLabel;

@end

@implementation TemperatureView

- (void)buildView {
    
    // 尺寸
    CGRect rect = CGRectMake(0, 0, 160, 140);
    
    // 计数的数据
    self.countLabel        = [[TemperatureCountLabel alloc] initWithFrame:rect];
    self.countLabel.center = self.middlePoint;
    [self addSubview:self.countLabel];
    self.countLabelStoreValue           = [CGRectStoreValue new];
    self.countLabelStoreValue.midRect   = self.countLabel.frame;
    self.countLabel.x                  += 10;
    self.countLabelStoreValue.startRect = self.countLabel.frame;
    self.countLabel.x                  -= 20;
    self.countLabelStoreValue.endRect   = self.countLabel.frame;
    self.countLabel.frame = self.countLabelStoreValue.startRect;
    
    // 标题
    self.titleMoveLabel = [TitleMoveLabel withText:@"Temperature"];
    [self addSubview:self.titleMoveLabel];
}

- (void)show {
    
    CGFloat duration = 1.75f;
    
    self.countLabel.toValue = self.temperature;
    [self.countLabel showDuration:duration];
    
    [self.titleMoveLabel show];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.frame = self.countLabelStoreValue.midRect;
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75f;
    [self.countLabel hideDuration:duration];
    
    [self.titleMoveLabel hide];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.frame = self.countLabelStoreValue.endRect;
        
    } completion:^(BOOL finished) {
        
        self.countLabel.frame = self.countLabelStoreValue.startRect;
    }];
}

@end
