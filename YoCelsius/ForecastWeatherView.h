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

@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *cityName;
- (void)buildView;
- (void)show;
- (void)hide;

@property (nonatomic, class, readonly) CGFloat viewHeight;

@end
