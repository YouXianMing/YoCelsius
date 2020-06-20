//
//  CALayer+MaskLayer.h
//  TestCAEmitterLayer
//
//  Created by YouXianMing on 14/10/17.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (MaskLayer)

/**
 *  根据PNG图片创建出用于mask的layer
 *
 *  @param size  mask的尺寸
 *  @param image 用于mask的图片
 *
 *  @return 创建好的mask的layer
 */
+ (CALayer *)createMaskLayerWithSize:(CGSize)size maskPNGImage:(UIImage *)image;

@end
