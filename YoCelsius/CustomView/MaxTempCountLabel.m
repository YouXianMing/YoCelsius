//
//  MaxTempCountLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "MaxTempCountLabel.h"

@interface MaxTempCountLabel ()<NumberCountDelegate>

@end

@implementation MaxTempCountLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.countLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.countLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.countLabel];
        self.countLabel.alpha         = 0;
        
        self.maxTempCount          = [MaxTempCount new];
        self.maxTempCount.delegate = self;
        
    }
    
    return self;
}

- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string {
    
    self.countLabel.attributedText = string;
}

- (void)showDuration:(CGFloat)duration {
    
    self.maxTempCount.fromValue = self.fromValue;
    self.maxTempCount.toValue   = self.toValue;
    self.maxTempCount.duration  = duration;
    
    [self.maxTempCount startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.alpha     = 1.f;
    }];
}

- (void)hideDuration:(CGFloat)duration {
    
    self.maxTempCount.fromValue = self.toValue;
    self.maxTempCount.toValue   = 0;
    self.maxTempCount.duration  = duration;
    
    [self.maxTempCount startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.countLabel.alpha     = 0.f;
    }];
}

@end
