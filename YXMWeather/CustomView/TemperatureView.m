//
//  TemperatureView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/22.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "TemperatureView.h"
#import "TemperatureCountLabel.h"

@interface TemperatureViewStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation TemperatureViewStoreValue
@end

@interface TemperatureView ()
@property (nonatomic, strong) TemperatureCountLabel     *countLabel;
@property (nonatomic, strong) TemperatureViewStoreValue *countLabelStoreValue;
@end

@implementation TemperatureView

- (void)buildView {
    
    // 尺寸
    CGRect rect = CGRectMake(0, 0, 160, 140);
    
    // 计数的数据
    self.countLabel    = [[TemperatureCountLabel alloc] initWithFrame:rect];
    self.countLabel.center = self.middlePoint;
    [self addSubview:self.countLabel];
    self.countLabelStoreValue = [TemperatureViewStoreValue new];
    self.countLabelStoreValue.midRect = self.countLabel.frame;
    self.countLabel.x -= 10;
    self.countLabelStoreValue.startRect = self.countLabel.frame;
    self.countLabel.x += 20;
    self.countLabelStoreValue.endRect = self.countLabel.frame;
    self.countLabel.frame = self.countLabelStoreValue.startRect;
}

- (void)show {
    CGFloat duration = 1.75f;
    
    self.countLabel.toValue = self.temperature;
    [self.countLabel showDuration:duration];
    
    [UIView animateWithDuration:duration animations:^{
        self.countLabel.frame = self.countLabelStoreValue.midRect;
    }];
}

- (void)hide {
    CGFloat duration = 0.75f;
    [self.countLabel hideDuration:duration];
    
    
    [UIView animateWithDuration:duration animations:^{
        self.countLabel.frame = self.countLabelStoreValue.endRect;
    } completion:^(BOOL finished) {
        self.countLabel.frame = self.countLabelStoreValue.startRect;
    }];
}


@end
