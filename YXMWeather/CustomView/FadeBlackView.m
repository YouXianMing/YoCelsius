//
//  FadeBlackView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/28.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "FadeBlackView.h"

@implementation FadeBlackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, Height)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha           = 0.f;
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0.75f;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.75f animations:^{
        self.alpha = 0.f;
    }];
}

@end
