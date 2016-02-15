//
//  PathDirectionView.m
//  Path
//
//  Created by XianMingYou on 15/2/27.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "PathDirectionView.h"

@interface PathDirectionView () {
    
    CAShapeLayer  *_shapeLayer;
}

@end

@implementation PathDirectionView

/**
 *  修改当前view的backupLayer为CAGradientLayer
 *
 *  @return CAGradientLayer类名字
 */
+ (Class)layerClass {
    
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _shapeLayer             = (CAShapeLayer *)self.layer;
        _shapeLayer.fillColor   = [[UIColor clearColor] CGColor];
        _shapeLayer.strokeColor = [[UIColor redColor] CGColor];
        _shapeLayer.lineWidth   = 1.f;
        _shapeLayer.strokeEnd   = 0.f;
        _shapeLayer.opacity     = 0.f;
        _shapeLayer.path        = [self createPathWithHeight:0];
    }
    
    return self;
}

/**
 *  创建出贝塞尔曲线
 *
 *  @param height 高度
 *
 *  @return 贝塞尔曲线
 */
- (CGPathRef)createPathWithHeight:(CGFloat)height {
    
    UIBezierPath *bezierPath = UIBezierPath.bezierPath;
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint   = CGPointZero;
    
    if (self.startPointAtRight == NO) {
        
        startPoint = CGPointMake(self.width, height);
        endPoint   = CGPointZero;
        
    } else {
        
        startPoint = CGPointMake(0, height);
        endPoint   = CGPointMake(self.width, 0);
    }
    
    [bezierPath moveToPoint:startPoint];
    [bezierPath addLineToPoint:endPoint];
    
    return bezierPath.CGPath;
}


- (void)showPercent:(CGFloat)percent {
    
    if (percent < 0) {
        
        _shapeLayer.path      = [self createPathWithHeight:0];
        _shapeLayer.strokeEnd = 0;
        _shapeLayer.opacity   = 0;
        
    } else if (percent >= 0 && percent <= 0.5f) { // [0, 0.5]
        
        _shapeLayer.path      = [self createPathWithHeight:0];
        _shapeLayer.strokeEnd = percent * 2.f;
        _shapeLayer.opacity   = percent * 2.f;
        
    } else if (percent <= 1.f) { // (0.5, 1]
        
        CGFloat currentPercent = percent - 0.5f;
        _shapeLayer.path      = [self createPathWithHeight:currentPercent * self.height * 2];
        _shapeLayer.strokeEnd = 1.f;
        _shapeLayer.opacity   = 1.f;
        
    } else { // (1, +无穷大)
        
        _shapeLayer.path      = [self createPathWithHeight:self.height];
        _shapeLayer.strokeEnd = 1.f;
        _shapeLayer.opacity   = 1.f;
    }
}

@end
