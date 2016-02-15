//
//  ChangeColorLabel.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface ChangeColorLabel : UIView

@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, strong) UIColor  *changedColor;

/**
 *  文本
 */
@property (nonatomic, strong) NSString *text;

/**
 *  设定文本后将会重新更新控件
 */
- (void)updateLabelView;

/**
 *  颜色百分比
 *
 *  @param percent 颜色的百分比
 */
- (void)colorPercent:(CGFloat)percent;

@end
