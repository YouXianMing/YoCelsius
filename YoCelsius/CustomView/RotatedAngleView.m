//
//  RotatedAngleView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "RotatedAngleView.h"

// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
#define   DEGREES(radian)  ((radian) * 180.f / M_PI)

@interface RotatedAngleView ()

/**
 *  默认的旋转值
 */
@property (nonatomic, assign) CGAffineTransform  defaultTransform;

@end

@implementation RotatedAngleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 存储默认的旋转值
        self.defaultTransform = self.transform;
    }
    
    return self;
}

- (void)roateAngle:(CGFloat)angle duration:(CGFloat)duration {
        
    [UIView animateWithDuration:duration animations:^{
        
        self.transform = CGAffineTransformRotate(_defaultTransform, RADIAN(angle));
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)roateAngle:(CGFloat)angle {
    
    self.transform = CGAffineTransformRotate(_defaultTransform, RADIAN(angle));
}

- (void)recoverDuration:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.transform = CGAffineTransformRotate(_defaultTransform, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
