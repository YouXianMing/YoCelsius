//
//  UILabel+Temperature.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
