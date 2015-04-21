//
//  LineAnimationView.m
//  AnimatedLineView
//
//  Created by XianMingYou on 15/3/4.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "LineAnimationView.h"

@implementation LineAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha              = 0.f;
        self.maxAlpha           = 0.1f;
        self.fadeToShowDuration = 1.75f;
        self.fadeToHideDuration = 0.75f;
    }
    return self;
}

- (void)show {}
- (void)hide {}

@end
