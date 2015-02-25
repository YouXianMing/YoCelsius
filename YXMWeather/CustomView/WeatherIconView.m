//
//  WeatherIconView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/24.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "WeatherIconView.h"
#import "TitleMoveLabel.h"
#import "UIView+GlowView.h"

@interface WeatherIconView ()

@property (nonatomic, strong) TitleMoveLabel *titleMoveLabel;
@property (nonatomic, strong) UILabel        *glowLabel;

@end

@implementation WeatherIconView

/**
 *  创建出view
 */
- (void)buildView {
    self.titleMoveLabel = [TitleMoveLabel withText:@"Weather"];
    [self addSubview:self.titleMoveLabel];
    
    
    self.glowLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.glowLabel.textAlignment = NSTextAlignmentCenter;
    self.glowLabel.font          = [UIFont fontWithName:WEATHER_TIME size:80];
    self.GCDTimerInterval        = @(1.75);
    self.glowLayerOpacity        = @(1.5);
    self.glowDuration            = @(1.f);
    self.glowLabel.alpha         = 1.f;
    self.glowLabel.text          = @"K";
    [self.glowLabel createGlowLayerWithColor:[UIColor redColor] glowRadius:2.f];
    [self.glowLabel startGlow];
    self.glowLabel.alpha         = 0.f;
    [self addSubview:self.glowLabel];
}

/**
 *  显示
 */
- (void)show {
    [self.titleMoveLabel show];
    
    [UIView animateWithDuration:1.75 animations:^{
        self.glowLabel.alpha = 1.f;
    }];
}

/**
 *  隐藏
 */
- (void)hide {
    [self.titleMoveLabel hide];
    
    [UIView animateWithDuration:0.75 animations:^{
        self.glowLabel.alpha = 0.f;
    }];
}

@end
