//
//  LabelView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/16.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "NSString+StringHeight.h"

@interface LabelView : UIView

/**
 *  文本
 */
@property (nonatomic, strong) NSString  *text;

/**
 *  文本颜色
 */
@property (nonatomic, strong) UIColor   *textColor;

/**
 *  文本字体
 */
@property (nonatomic, strong) UIFont    *font;

/**
 *  背景色
 */
@property (nonatomic, strong) UIColor   *color;

/**
 *  距离顶部的距离
 */
@property (nonatomic) CGFloat gapFromTop;

/**
 *  距离底部的距离
 */
@property (nonatomic) CGFloat gapFromBottom;

/**
 *  距离左侧的距离
 */
@property (nonatomic) CGFloat gapFromLeft;

/**
 *  距离右侧的距离
 */
@property (nonatomic) CGFloat gapFromRight;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  创建出默认配置的label
 *
 *  @param text   字符串
 *  @param origin 起始位置
 *
 *  @return 实例对象
 */
+ (instancetype)createWithText:(NSString *)text atOrigin:(CGPoint)origin;

@end
