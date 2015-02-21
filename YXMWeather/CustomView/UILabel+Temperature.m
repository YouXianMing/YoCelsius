//
//  UILabel+Temperature.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "UILabel+Temperature.h"

@implementation UILabel (Temperature)

+ (UILabel *)labelWithNumberText:(NSString *)text tag:(int)tag {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 100)];
    label.text          = text;
    label.tag           = tag;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = COLOR_PURE_;
    label.font          = [UIFont fontWithName:LATO_THIN size:75.f];

    return label;
}

@end
