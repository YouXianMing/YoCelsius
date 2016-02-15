//
//  CityTitleView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "CityTitleView.h"
#import "CGRectStoreValue.h"

@interface CityTitleView ()

@property (nonatomic, strong) UILabel          *baseLabel;       // 基站label
@property (nonatomic, strong) CGRectStoreValue *baseLabelStoreValue;

@property (nonatomic, strong) UILabel          *cityNameLabel;   // 城市名字label
@property (nonatomic, strong) CGRectStoreValue *cityNameLabelStoreValue;

@property (nonatomic, strong) UILabel          *weatherDesLabel; // 天气描述label
@property (nonatomic, strong) CGRectStoreValue *weatherDesLabelStoreValue;

@property (nonatomic, strong) UILabel          *updateYearLabel; // 更新年份label
@property (nonatomic, strong) CGRectStoreValue *updateYearLabelStoreValue;

@property (nonatomic, strong) UILabel          *updateHourLabel; // 更新的小时label
@property (nonatomic, strong) CGRectStoreValue *updateHourLabelStoreValue;

@property (nonatomic, strong) UIView           *blackView;       // 黑色的view
@property (nonatomic, strong) CGRectStoreValue *blackViewStoreValue;

@property (nonatomic, strong) UIView           *redView;         // 红色的view
@property (nonatomic, strong) CGRectStoreValue *redViewStoreValue;

@property (nonatomic, strong) EmitterLayerView *weatherConditionView;

@end

@implementation CityTitleView

// 从右向左运动
- (void)moveToLeftWithMidRect:(CGRect)rect
                 moveDistance:(CGFloat)distance
               withStoreValue:(CGRectStoreValue *)storeValue {
    
    CGRect midRect   = rect;
    CGRect startRect = CGRectMake(rect.origin.x + distance,
                                  rect.origin.y,
                                  rect.size.width,
                                  rect.size.height);
    CGRect endRect   = CGRectMake(rect.origin.x - distance,
                                  rect.origin.y,
                                  rect.size.width,
                                  rect.size.height);
    
    storeValue.midRect   = midRect;
    storeValue.startRect = startRect;
    storeValue.endRect   = endRect;
}

- (void)moveToRightWithMidRect:(CGRect)rect
                  moveDistance:(CGFloat)distance
                withStoreValue:(CGRectStoreValue *)storeValue {
    
    CGRect midRect   = rect;
    CGRect startRect = CGRectMake(rect.origin.x - distance,
                                  rect.origin.y,
                                  rect.size.width,
                                  rect.size.height);
    CGRect endRect   = CGRectMake(rect.origin.x + distance,
                                  rect.origin.y,
                                  rect.size.width,
                                  rect.size.height);
    
    storeValue.midRect   = midRect;
    storeValue.startRect = startRect;
    storeValue.endRect   = endRect;
}

- (void)buildView {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.90f];
    
    // 基站信息
    self.baseLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Width - 8, 12.f)];
    self.baseLabel.textAlignment = NSTextAlignmentRight;
    self.baseLabel.font          = [UIFont fontWithName:LATO_BOLD size:10.f];
    self.baseLabel.text          = @"cmc station";
    self.baseLabelStoreValue     = [CGRectStoreValue new];
    [self moveToLeftWithMidRect:self.baseLabel.frame
                   moveDistance:10
                 withStoreValue:self.baseLabelStoreValue];
    self.baseLabel.frame         = self.baseLabelStoreValue.startRect;
    self.baseLabel.alpha         = 0.f;
    [self addSubview:self.baseLabel];
    
    // 黑色的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 44)];
        
    } else if (iPhone6_6s) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 60)];
        
    } else if (iPhone6_6sPlus) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 60)];
        
    } else {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 44)];
    }
    
    self.blackView.backgroundColor     = [UIColor blackColor];
    [self addSubview:self.blackView];
    self.blackViewStoreValue           = [CGRectStoreValue new];
    self.blackViewStoreValue.midRect   = self.blackView.frame;
    self.blackView.x                  -= 5;
    self.blackViewStoreValue.startRect = self.blackView.frame;
    self.blackView.x                  += 5;
    self.blackView.y                  += 5;
    self.blackViewStoreValue.endRect   = self.blackView.frame;
    self.blackView.frame               = self.blackViewStoreValue.startRect;
    self.blackView.alpha               = 0.f;
    
    // 红色的view
    CGFloat redViewWidth = 100;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        redViewWidth = 100;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 44)];
        
    } else if (iPhone6_6s) {
        
        redViewWidth = 135;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 60)];
        
    } else if (iPhone6_6sPlus) {
        
        redViewWidth = 135;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 60)];
        
    } else {
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 44)];
    }
    
    self.redView.backgroundColor = [UIColor redColor];
    [self addSubview:self.redView];
    self.redViewStoreValue = [CGRectStoreValue new];
    [self moveToLeftWithMidRect:self.redView.frame
                   moveDistance:30.f
                 withStoreValue:self.redViewStoreValue];
    self.redView.frame = self.redViewStoreValue.startRect;
    self.redView.alpha = 0.f;
    
    // 年份的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 12.f)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:10];
        
    } else if (iPhone6_6s) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 18)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:16];
        
    } else if (iPhone6_6sPlus) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 18)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:16];
        
    } else {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 12.f)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:10];
    }
    
    [self addSubview:self.updateYearLabel];
    self.updateYearLabelStoreValue = [CGRectStoreValue new];
    [self moveToLeftWithMidRect:self.updateYearLabel.frame
                   moveDistance:20.f
                 withStoreValue:self.updateYearLabelStoreValue];
    self.updateYearLabel.frame = self.updateYearLabelStoreValue.startRect;
    self.updateYearLabel.alpha = 0.f;
    
    // 小时的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, Width - 8, 14.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:12];
        
    } else if (iPhone6_6s) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, Width - 8, 20.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:16];
        
    } else if (iPhone6_6sPlus) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, Width - 8, 20.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:16];
        
    } else {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, Width - 8, 14.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:12];
    }
    
    [self addSubview:self.updateHourLabel];
    self.updateHourLabelStoreValue = [CGRectStoreValue new];
    [self moveToLeftWithMidRect:self.updateHourLabel.frame
                   moveDistance:15.f
                 withStoreValue:self.updateHourLabelStoreValue];
    self.updateHourLabel.frame = self.updateHourLabelStoreValue.startRect;
    self.updateHourLabel.alpha = 0.f;
    
    // 城市label
    if (iPhone4_4s || iPhone5_5s) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:26.f];

    } else if (iPhone6_6s) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_LIGHT size:30.f];
        
    } else if (iPhone6_6sPlus) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_LIGHT size:30.f];
        
    } else {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:26.f];
    }
    
    [self addSubview:self.cityNameLabel];
    [self.cityNameLabel sizeToFit];
    self.cityNameLabel.width = Width - 10;
    self.cityNameLabelStoreValue = [CGRectStoreValue new];
    [self moveToRightWithMidRect:self.cityNameLabel.frame
                    moveDistance:5
                  withStoreValue:self.cityNameLabelStoreValue];
    self.cityNameLabel.frame = self.cityNameLabelStoreValue.startRect;
    self.cityNameLabel.alpha = 0.f;
    
    // 天气描述用的label
    if (iPhone4_4s || iPhone5_5s) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:14.f];
        
    } else if (iPhone6_6s) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 62, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:16.f];
        
    } else if (iPhone6_6sPlus) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 62, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:16.f];
        
    } else {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:14.f];
    }
    
    [self addSubview:self.weatherDesLabel];
    [self.weatherDesLabel sizeToFit];
    self.weatherDesLabel.width = Width - 10;
    self.weatherDesLabelStoreValue = [CGRectStoreValue new];
    [self moveToRightWithMidRect:self.weatherDesLabel.frame
                    moveDistance:8
                  withStoreValue:self.weatherDesLabelStoreValue];
    self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.startRect;
    self.weatherDesLabel.alpha = 0.f;
}

- (void)show {
    
    CGFloat duration = 1.75f;
    EMitterType type = [WeatherNumberMeaningTransform emitterTypeWithNumber:self.weatherNumber];
    
    // 表述类型
    if (type == __RAIN) {
        
        self.weatherConditionView = [[RainView alloc] initWithFrame:CGRectMake(0, 0, Width / 2.f, Height - Width - Width / 2.f)];
        [self.weatherConditionView configType:__RAIN];
        [self.weatherConditionView show];
        [self addSubview:self.weatherConditionView];
        
    } else if (type == __SNOW) {
        
        self.weatherConditionView = [[SnowView alloc] initWithFrame:CGRectMake(0, 0, Width / 2.f, Height - Width - Width / 2.f)];
        [self.weatherConditionView configType:__SNOW];
        [self.weatherConditionView show];
        [self addSubview:self.weatherConditionView];
        
    } else if (type == __NONE) {
        
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.baseLabel.frame = self.baseLabelStoreValue.midRect;
        self.baseLabel.alpha = 1.f;
        
        self.cityNameLabel.frame = self.cityNameLabelStoreValue.midRect;
        self.cityNameLabel.alpha = 1.f;
        
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.midRect;
        self.weatherDesLabel.alpha = 1.f;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.midRect;
        self.updateYearLabel.alpha = 1.f;
        
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.midRect;
        self.updateHourLabel.alpha = 1.f;
        
        self.redView.frame = self.redViewStoreValue.midRect;
        self.redView.alpha = 1.f;
        
        self.blackView.frame = self.blackViewStoreValue.midRect;
        self.blackView.alpha = 1.f;
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75f;
    
    [self.weatherConditionView hide];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.baseLabel.frame = self.baseLabelStoreValue.endRect;
        self.baseLabel.alpha = 0.f;
        
        self.cityNameLabel.frame = self.cityNameLabelStoreValue.endRect;
        self.cityNameLabel.alpha = 0.f;
        
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.endRect;
        self.weatherDesLabel.alpha = 0.f;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.endRect;
        self.updateYearLabel.alpha = 0.f;
        
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.endRect;
        self.updateHourLabel.alpha = 0.f;
        
        self.redView.frame = self.redViewStoreValue.endRect;
        self.redView.alpha = 0.f;
        
        self.blackView.frame = self.blackViewStoreValue.endRect;
        self.blackView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.baseLabel.frame       = self.baseLabelStoreValue.startRect;
        
        self.cityNameLabel.frame   = self.cityNameLabelStoreValue.startRect;
        
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.startRect;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.startRect;
        
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.startRect;
        
        self.redView.frame = self.redViewStoreValue.startRect;
        
        self.blackView.frame = self.blackViewStoreValue.startRect;
        self.blackView.alpha = 1.f;
        
        // 移除天气view
        [self.weatherConditionView removeFromSuperview];
    }];
}


#pragma mark - 重写setter,getter方法

@synthesize cityName = _cityName;

- (void)setCityName:(NSString *)cityName {
    
    _cityName           = cityName;
    _cityNameLabel.text = cityName;
    [_cityNameLabel sizeToFit];
}

- (NSString *)cityName {
    
    return _cityName;
}

@synthesize weatherDescription = _weatherDescription;

- (void)setWeatherDescription:(NSString *)weatherDescription {
    
    _weatherDescription   = weatherDescription;
    _weatherDesLabel.text = weatherDescription;
    [_weatherDesLabel sizeToFit];
}

- (NSString *)weatherDescription {
    
    return _weatherDescription;
}

@synthesize baseStation = _baseStation;

- (void)setBaseStation:(NSString *)baseStation {
    
    _baseStation    = baseStation;
    _baseLabel.text = baseStation;
}

- (NSString *)baseStation {
    
    return _baseStation;
}

@synthesize utcSec = _utcSec;

- (void)setUtcSec:(NSTimeInterval)utcSec {
    
    _utcSec = utcSec;
    
    NSDate *utcDate = [NSDate dateWithTimeIntervalSince1970:utcSec];
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *yearStr = [formatter stringFromDate:utcDate];
    self.updateYearLabel.text = yearStr;
    
    [formatter setDateFormat:@"hh:mm"];
    NSString *hourStr = [NSString stringWithFormat:@"%@ update", [formatter stringFromDate:utcDate]];
    self.updateHourLabel.text = hourStr;
}

- (NSTimeInterval)utcSec {
    
    return _utcSec;
}

@end
