//
//  Sun.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "Sun.h"

@implementation Sun

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initRects];
    }
    
    return self;
}

/**
 *  初始化view
 */
- (void)initRects {
    
    CGFloat width  = self.width;
    CGFloat height = self.height / 2.f;
    
    self.upCenterRect   = CGRectMake(0, 0, width, height);
    self.downCenterRect = CGRectMake(0, height, width, height);
}

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)showWithDuration:(CGFloat)duration {

}

/**
 *  隐藏动画
 *
 *  @param duration 动画时间
 */
- (void)hideWithDuration:(CGFloat)duration {

}

@end
