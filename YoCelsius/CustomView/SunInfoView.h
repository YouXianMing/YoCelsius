//
//  SunInfoView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "SunriseAndSunset.h"

@interface SunInfoView : UIView

/**
 *  日出的值
 */
@property (nonatomic, strong) SunriseAndSunset  *sunsireValue;

/**
 *  日落的值
 */
@property (nonatomic, strong) SunriseAndSunset  *sunsetValue;

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
