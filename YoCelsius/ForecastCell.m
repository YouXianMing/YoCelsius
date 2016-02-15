//
//  ForecastCell.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/26.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ForecastCell.h"
#import "WeatherInfo.h"
#import "WeatherNumberMeaningTransform.h"

@interface ForecastCell ()

@property (nonatomic, strong) UILabel  *weekDayInfoLabel;
@property (nonatomic, strong) UILabel  *dateLabel;
@property (nonatomic, strong) UILabel  *minTempLabel;
@property (nonatomic, strong) UILabel  *maxTempLabel;
@property (nonatomic, strong) UILabel  *weatherLabel;
@property (nonatomic, strong) UILabel  *weatherInfoLabel;

@end

@implementation ForecastCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化标签
        [self initLabels];
    }
    
    return self;
}

- (void)initLabels {
    
    // 星期几
    if (iPhone4_4s || iPhone5_5s) {
        
        self.weekDayInfoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(17 + 10, 24, 100, 60)];
        self.weekDayInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.weekDayInfoLabel.font          = [UIFont fontWithName:LATO_THIN size:28.f];
        self.weekDayInfoLabel.text          = @"Today";
        
    } else if (iPhone6_6s) {
        
        self.weekDayInfoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(17 + 10, 24, 100, 60)];
        self.weekDayInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.weekDayInfoLabel.font          = [UIFont fontWithName:LATO_THIN size:34.f];
        self.weekDayInfoLabel.text          = @"Today";
        
    } else if (iPhone6_6sPlus) {
        
        self.weekDayInfoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(17 + 10, 24, 100, 60)];
        self.weekDayInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.weekDayInfoLabel.font          = [UIFont fontWithName:LATO_THIN size:40.f];
        self.weekDayInfoLabel.text          = @"Today";
        
    } else {
        
        self.weekDayInfoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(17 + 10, 24, 100, 60)];
        self.weekDayInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.weekDayInfoLabel.font          = [UIFont fontWithName:LATO_THIN size:28.f];
        self.weekDayInfoLabel.text          = @"Today";
    }
    
    [self.weekDayInfoLabel sizeToFit];
    [self addSubview:self.weekDayInfoLabel];
    
    // 日期
    self.dateLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 12.f)];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font          = [UIFont fontWithName:LATO_REGULAR size:8.f];
    self.dateLabel.text          = @"2015.2.25";
    self.dateLabel.textColor     = [UIColor whiteColor];
    
    UIView *dateBlackView         = [[UIView alloc] initWithFrame:CGRectMake(Width - 50, 0, 50, 12.f)];
    dateBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.95];
    [dateBlackView addSubview:self.dateLabel];
    
    // 最低温度
    if (iPhone4_4s || iPhone5_5s) {
        
        self.minTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 70)];
        self.minTempLabel.textAlignment = NSTextAlignmentLeft;
        self.minTempLabel.font          = [UIFont fontWithName:LATO_THIN size:28];
        self.minTempLabel.text          = @"-200.0°";
        
    } else if (iPhone6_6s) {
        
        self.minTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 200, 70)];
        self.minTempLabel.textAlignment = NSTextAlignmentLeft;
        self.minTempLabel.font          = [UIFont fontWithName:LATO_THIN size:34];
        self.minTempLabel.text          = @"-200.0°";
        
    } else if (iPhone6_6sPlus) {
        
        self.minTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 200, 70)];
        self.minTempLabel.textAlignment = NSTextAlignmentLeft;
        self.minTempLabel.font          = [UIFont fontWithName:LATO_THIN size:40];
        self.minTempLabel.text          = @"-200.0°";
        
    } else {
        
        self.minTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 70)];
        self.minTempLabel.textAlignment = NSTextAlignmentLeft;
        self.minTempLabel.font          = [UIFont fontWithName:LATO_THIN size:28];
        self.minTempLabel.text          = @"-200.0°";
    }
    
    [self.minTempLabel sizeToFit];
    [self addSubview:self.minTempLabel];
    
    // 最高温度
    if (iPhone4_4s || iPhone5_5s) {
        
        self.maxTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100 + 80, 25, 200, 70)];
        self.maxTempLabel.textAlignment = NSTextAlignmentLeft;
        self.maxTempLabel.font          = [UIFont fontWithName:LATO_THIN size:28];
        self.maxTempLabel.text          = @"-200.0°";
        
    } else if (iPhone6_6s) {
        
        self.maxTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100 + 80 + 20, 25, 200, 70)];
        self.maxTempLabel.textAlignment = NSTextAlignmentLeft;
        self.maxTempLabel.font          = [UIFont fontWithName:LATO_THIN size:34];
        self.maxTempLabel.text          = @"-200.0°";
        
    } else if (iPhone6_6sPlus) {
        
        self.maxTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100 + 80 + 40, 25, 200, 70)];
        self.maxTempLabel.textAlignment = NSTextAlignmentLeft;
        self.maxTempLabel.font          = [UIFont fontWithName:LATO_THIN size:40];
        self.maxTempLabel.text          = @"-200.0°";
        
    } else {
        
        self.maxTempLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100 + 80, 25, 200, 70)];
        self.maxTempLabel.textAlignment = NSTextAlignmentLeft;
        self.maxTempLabel.font          = [UIFont fontWithName:LATO_THIN size:28];
        self.maxTempLabel.text          = @"-200.0°";
    }
    
    [self.maxTempLabel sizeToFit];
    [self addSubview:self.maxTempLabel];
    
    // 天气图标
    if (iPhone4_4s || iPhone5_5s) {
        
        self.weatherLabel               = [[UILabel alloc] initWithFrame:CGRectMake(250, 15, 60, 60)];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.font          = [UIFont fontWithName:WEATHER_TIME size:40.f];
        
    } else if (iPhone6_6s) {
        
        self.weatherLabel               = [[UILabel alloc] initWithFrame:CGRectMake(250 + 40, 20, 60, 60)];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.font          = [UIFont fontWithName:WEATHER_TIME size:45.f];
        
    } else if (iPhone6_6sPlus) {
        
        self.weatherLabel               = [[UILabel alloc] initWithFrame:CGRectMake(250 + 70, 24, 60, 60)];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.font          = [UIFont fontWithName:WEATHER_TIME size:50.f];
        
    } else {
        
        self.weatherLabel               = [[UILabel alloc] initWithFrame:CGRectMake(250, 15, 60, 60)];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.font          = [UIFont fontWithName:WEATHER_TIME size:40.f];
        
    }
    
    [self addSubview:self.weatherLabel];
    
    // 天气描述信息
    self.weatherInfoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 12)];
    self.weatherInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.weatherInfoLabel.font          = [UIFont fontWithName:LATO_REGULAR size:10];
    [self addSubview:self.weatherInfoLabel];
    
    // 线条
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, Width / 4.f - 0.5, Width, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha           = 0.1;
    [self addSubview:line];
}

- (void)acccessData:(id)data indexPath:(NSIndexPath *)indexPath {
    
    WeatherInfo *weatherInfo = data;
    
    // 最高温度
    NSString *maxTemp      = [NSString stringWithFormat:@"%d°", @(weatherInfo.temp.max.floatValue - 273.15).intValue];
    self.maxTempLabel.text = maxTemp;
    
    // 最低温度
    NSString *minTemp      = [NSString stringWithFormat:@"%d°", @(weatherInfo.temp.min.floatValue - 273.15).intValue];
    self.minTempLabel.text = minTemp;
    
    NSDate *utcDate            = [NSDate dateWithTimeIntervalSince1970:weatherInfo.dt.integerValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    // 更新图标
    Weather *weather       = weatherInfo.weather[0];
    self.weatherLabel.text = [WeatherNumberMeaningTransform fontTextWeatherNumber:weather.weatherId];
    
    // 天气描述信息
    self.weatherInfoLabel.text = weather.descriptionInfo;
    
    // 年份
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *yearStr   = [formatter stringFromDate:utcDate];
    self.dateLabel.text = yearStr;
    
    // 星期几
    [formatter setDateFormat:@"EEEE"];
    [formatter setWeekdaySymbols:@[@"Sun", @"Mon", @"Tues", @"Wed", @"Thur", @"Fri", @"Sat"]];
    self.weekDayInfoLabel.textColor = [UIColor blackColor];
    NSString *hourStr               = [NSString stringWithFormat:@"%@", [formatter stringFromDate:utcDate]];
    self.weekDayInfoLabel.text      = hourStr;
    if ([hourStr isEqualToString:@"Sun"]) {
        
        self.weekDayInfoLabel.textColor = [UIColor redColor];
        
    } else {
        
        self.weekDayInfoLabel.textColor = [UIColor blackColor];
    }
}

/**
 *  显示
 */
- (void)show {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.weekDayInfoLabel.x = 17;
    }];
}

/**
 *  隐藏
 */
- (void)hide {
    
    self.weekDayInfoLabel.x = 17 + 10;
}

@end
