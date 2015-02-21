//
//  UILabel+Temperature.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Temperature)

/**
 *  frame值为(0, 0, 45, 100)
 *
 *  @param text 文本
 *  @param tag  该label的tag值
 *
 *  @return 该label
 */
+ (UILabel *)labelWithNumberText:(NSString *)text tag:(int)tag;

@end
