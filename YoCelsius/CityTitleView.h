//
//  CityTitleView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "SnowView.h"
#import "RainView.h"
#import "WeatherNumberMeaningTransform.h"

@interface CityTitleView : UIView

@property (nonatomic, strong) NSString       *cityName;
@property (nonatomic, strong) NSString       *cityCode;
@property (nonatomic, strong) NSString       *weatherDescription;
@property (nonatomic, strong) NSString       *baseStation;
@property (nonatomic, strong) NSString       *updateYear;
@property (nonatomic, strong) NSString       *updateHour;
@property (nonatomic)         NSTimeInterval  utcSec;
@property (nonatomic, strong) NSNumber       *weatherNumber;

// 创建view
- (void)buildView;

// 显示view
- (void)show;

// 隐藏view
- (void)hide;

@end
