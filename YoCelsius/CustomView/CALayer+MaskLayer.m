//
//  CALayer+MaskLayer.m
//  TestCAEmitterLayer
//
//  Created by YouXianMing on 14/10/17.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "CALayer+MaskLayer.h"

@implementation CALayer (MaskLayer)

+ (CALayer *)createMaskLayerWithSize:(CGSize)size maskPNGImage:(UIImage *)image {
    
    CALayer *layer    = [CALayer layer];
    layer.anchorPoint = CGPointMake(0, 0);                          // 重置锚点
    layer.bounds      = CGRectMake(0, 0, size.width, size.height);  // 设置尺寸
    
    if (image) {
        
        layer.contents = (__bridge id)(image.CGImage);
    }

    return layer;
}

@end
