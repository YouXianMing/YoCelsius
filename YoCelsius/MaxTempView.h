//
//  MaxTempView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface MaxTempView : UIView

/**
 *  最高温度
 */
@property (nonatomic) CGFloat maxTemp;

/**
 *  最低温度
 */
@property (nonatomic) CGFloat minTemp;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
