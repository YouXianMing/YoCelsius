//
//  ConfigAttributedString.h
//  NSMutableAttributedString
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConfigAttributedString : NSObject

@property (nonatomic, strong, readonly) NSString *attribute; // 富文本属性
@property (nonatomic, strong, readonly) id        value;     // 富文本值
@property (nonatomic, assign, readonly) NSRange   range;     // 富文本范围值

// 通用型配置
+ (instancetype)attribute:(NSString *)attribute value:(id)value range:(NSRange)range;

// 配置字体
+ (instancetype)font:(UIFont *)font range:(NSRange)range;

// 配置字体颜色
+ (instancetype)foregroundColor:(UIColor *)color range:(NSRange)range;

// 配置字体背景颜色
+ (instancetype)backgroundColor:(UIColor *)color range:(NSRange)range;

// 字体描边颜色以及描边宽度以及阴影(以下两个方法可以一起使用)
+ (instancetype)strokeColor:(UIColor *)color range:(NSRange)range;
+ (instancetype)strokeWidth:(float)number range:(NSRange)range;
+ (instancetype)shadow:(NSShadow *)shadow range:(NSRange)range;

// 配置文字的中划线
+ (instancetype)strikethroughStyle:(NSInteger)number range:(NSRange)range;

// 配置文字的下划线
+ (instancetype)underlineStyle:(NSInteger)number range:(NSRange)range;

// 字间距
+ (instancetype)kern:(float)number range:(NSRange)range;

// 段落样式(需要将UILabel中的numberOfLines设置成0才有用)
+ (instancetype)paragraphStyle:(NSMutableParagraphStyle *)style range:(NSRange)range;

@end
