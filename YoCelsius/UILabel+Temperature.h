//
//  UILabel+Temperature.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
