//
//  WeatherIconView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherIconView.h"
#import "TitleMoveLabel.h"
#import "UIView+GlowView.h"
#import "WeatherNumberMeaningTransform.h"
#import "CGRectStoreValue.h"

@interface WeatherIconViewStoreValue : NSObject

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation WeatherIconViewStoreValue

@end

@interface WeatherIconView ()

@property (nonatomic, strong) TitleMoveLabel     *titleMoveLabel;
@property (nonatomic, strong) UILabel            *glowLabel;
@property (nonatomic, strong) CGRectStoreValue   *storeValue;

@end

@implementation WeatherIconView

- (void)buildView {
    
    self.titleMoveLabel = [TitleMoveLabel withText:@"Weather"];
    [self addSubview:self.titleMoveLabel];
    
    self.storeValue = [CGRectStoreValue new];
}

- (void)show {
    
    [self.titleMoveLabel show];
    
    // 创建
    self.glowLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.glowLabel.textAlignment = NSTextAlignmentCenter;
    
    if (Screen_Size_Middle) {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:110];
        self.glowLabel.y         = 14;
        self.glowLabel.x         = 0;

    } else if (Screen_Size_Big) {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:110];
        self.glowLabel.y         = 14;
        self.glowLabel.x         = 8;
        
    } else {
        
        self.glowLabel.font      = [UIFont fontWithName:WEATHER_TIME size:80];
    }
    
    self.storeValue.midRect      = self.glowLabel.frame;
    self.glowLabel.y            -= 10;
    self.storeValue.startRect    = self.glowLabel.frame;
    self.glowLabel.y            += 20;
    self.storeValue.endRect      = self.glowLabel.frame;
    self.glowLabel.frame         = self.storeValue.startRect;
    
    self.GCDTimerInterval        = @(1.75);
    self.glowLayerOpacity        = @(1.5);
    self.glowDuration            = @(1.f);
    self.glowLabel.alpha         = 1.f;
    self.glowLabel.text          = [WeatherNumberMeaningTransform fontTextWeatherNumber:self.weatherNumber];
    [self.glowLabel createGlowLayerWithColor:[WeatherNumberMeaningTransform iconColor:self.weatherNumber] glowRadius:2.f];
    [self.glowLabel startGlow];
    self.glowLabel.alpha         = 0.f;
    [self addSubview:self.glowLabel];

    [UIView animateWithDuration:1.75 animations:^{
        
        self.glowLabel.alpha = 1.f;
        self.glowLabel.frame = self.storeValue.midRect;
    }];
}

- (void)hide {
    
    [self.titleMoveLabel hide];
    
    [UIView animateWithDuration:0.75 animations:^{
        
        self.glowLabel.alpha = 0.f;
        self.glowLabel.frame = self.storeValue.endRect;
        
    } completion:^(BOOL finished) {
        
        self.glowLabel.frame = self.storeValue.startRect;
        [self.glowLabel removeFromSuperview];
    }];
}

@end
