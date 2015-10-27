//
//  NSString+StringHeight.h
//  USA
//
//  Created by YouXianMing on 14/12/10.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHeight)

/**
 *  计算文本的高度
 *
 *  @param font  字体
 *  @param width 固定的宽度
 *
 *  @return 高度
 */
- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width;

/**
 *  计算文本的宽度
 *
 *  @param font 字体
 *
 *  @return 宽度
 */
- (CGFloat)widthWithLabelFont:(UIFont *)font;

@end
