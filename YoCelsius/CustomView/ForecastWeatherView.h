//
//  ForecastWeatherView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "LineBackgroundView.h"

@interface ForecastWeatherView : UIView

/**
 *  城市编号码
 */
@property (nonatomic, strong) NSString *countryCode;

/**
 *  城市名字
 */
@property (nonatomic, strong) NSString *cityName;

/**
 *  创建出view
 */
- (void)buildView;

- (void)show;
- (void)hide;

@end
