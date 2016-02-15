//
//  LeftToRightView.m
//  AnimatedLineView
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LeftToRightView.h"

@implementation LeftToRightView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat x      = frame.origin.x;
        CGFloat y      = frame.origin.y;
        CGFloat height = frame.size.height;
        CGFloat width  = frame.size.width;
        
        self.startFrame = CGRectMake(x, y, 0, height);
        self.midFrame   = CGRectMake(x, y, width, height);
        self.endFrame   = CGRectMake(x + width, y, 0, height);
        
        self.frame      = self.startFrame;
    }
    
    return self;
}

- (void)show {
    
    // 动画
    [UIView animateWithDuration:self.fadeToShowDuration animations:^{
        
        self.alpha = self.maxAlpha;
        self.frame = self.midFrame;
    }];
}

- (void)hide {
    
    // 动画
    [UIView animateWithDuration:self.fadeToHideDuration animations:^{
        
        self.alpha = 0.f;
        self.frame = self.endFrame;
        
    } completion:^(BOOL finished) {
        
        self.frame = self.startFrame;
        self.alpha = 0.f;
    }];
}

@end
