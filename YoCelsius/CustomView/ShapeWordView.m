//
//  ShapeWordView.m
//  PathWord
//
//  Created by XianMingYou on 15/3/6.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ShapeWordView.h"

@interface ShapeWordView ()

@property (nonatomic, strong) CAShapeLayer  *shapeLayer;

@end

@implementation ShapeWordView

- (void)buildView {
    
    // 过滤数据
    CGFloat   lineWidth   = (self.lineWidth <= 0 ? 0.5 : self.lineWidth);
    UIFont   *font        = (self.font == nil ? [UIFont systemFontOfSize:18.f] : self.font);
    UIColor  *lineColor   = (self.lineColor == nil ? [UIColor blackColor] : self.lineColor);
    NSString *text        = self.text;
    
    if (text == nil || text.length == 0) {
        
        return;
    }
    
    // 初始化layer
    self.shapeLayer             = [CAShapeLayer layer];
    self.shapeLayer.frame       = self.bounds;
    self.shapeLayer.lineWidth   = lineWidth;
    self.shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = lineColor.CGColor;
    self.shapeLayer.path = [UIBezierPath pathForMultilineString:text
                                                       withFont:font
                                                       maxWidth:self.bounds.size.width
                                                  textAlignment:NSTextAlignmentCenter].CGPath;
    self.shapeLayer.bounds          = CGPathGetBoundingBox(self.shapeLayer.path);
    self.shapeLayer.geometryFlipped = YES;
    self.shapeLayer.strokeEnd       = 0.f;
    [self.layer addSublayer:self.shapeLayer];
}

- (void)percent:(CGFloat)percent animated:(BOOL)animated {
    
    if (animated) {
        
        if (percent <= 0) {
            
            self.shapeLayer.strokeEnd = 0;
            
        } else if (percent > 0 && percent <= 1) {
            
            self.shapeLayer.strokeEnd = percent;
            
        } else {
            
            self.shapeLayer.strokeEnd = 1.f;
        }
        
    } else {
        
        if (percent <= 0) {
            
            [CATransaction setDisableActions:YES];
            self.shapeLayer.strokeEnd = 0;
            [CATransaction setDisableActions:NO];
            
        } else if (percent > 0 && percent <= 1) {
            
            [CATransaction setDisableActions:YES];
            self.shapeLayer.strokeEnd = percent;
            [CATransaction setDisableActions:NO];
            
        } else {
            
            [CATransaction setDisableActions:YES];
            self.shapeLayer.strokeEnd = 1.f;
            [CATransaction setDisableActions:NO];
        }
    }
}

@end
