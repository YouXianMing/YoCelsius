//
//  NSString+StringHeight.m
//  USA
//
//  Created by YouXianMing on 14/12/10.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import "NSString+StringHeight.h"

@implementation NSString (StringHeight)

- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width {
    
    CGFloat height = 0;
    
    if (self.length == 0) {
        
        height = 0;
        
    } else {

        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        height = retSize.height;
    }
    
    return height;
}

- (CGFloat)widthWithLabelFont:(UIFont *)font {
    
    CGFloat retHeight = 0;
    
    if (self.length == 0) {
        
        retHeight = 0;
        
    } else {
        
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        retHeight = retSize.width;
    }
    
    return retHeight;
}

@end
