//
//  WindSpeedCountLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/19.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WindSpeedCountLabel.h"

@interface WindSpeedCountLabel ()<NumberCountDelegate>

@end

@implementation WindSpeedCountLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.countLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
        self.countLabel.alpha         = 0;
        
        self.windSpeedCount          = [WindSpeedCount new];
        self.windSpeedCount.delegate = self;
    }
    
    return self;
}

- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string {
    
    self.countLabel.attributedText = string;
}

- (void)showDuration:(CGFloat)duration {
    
    self.windSpeedCount.fromValue = self.fromValue;
    self.windSpeedCount.toValue   = self.toValue;
    self.windSpeedCount.duration  = duration;
    
    [self.windSpeedCount startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.alpha     = 1.f;
    }];
}

- (void)hideDuration:(CGFloat)duration {
    
    self.windSpeedCount.fromValue = self.toValue;
    self.windSpeedCount.toValue   = 0;
    self.windSpeedCount.duration  = duration;
    
    [self.windSpeedCount startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.alpha     = 0.f;
    }];
}

@end
