//
//  WeatherView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/23.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "WeatherView.h"

#import "HumidityView.h"
#import "WindSpeedView.h"
#import "MaxTempView.h"
#import "SunInfoView.h"
#import "TemperatureView.h"

#import "ChangeColorLabel.h"
#import "WeatherTitleView.h"

@interface WeatherView ()<UITableViewDelegate>


@property (nonatomic, strong) ChangeColorLabel  *changeColorLabel;
@property (nonatomic, strong) UIView            *vLine;
@property (nonatomic, strong) UIView            *hLine;


@property (nonatomic, strong) WeatherTitleView  *titleView;


@property (nonatomic ,strong) HumidityView      *humidityView;
@property (nonatomic, strong) WindSpeedView     *windSpeedView;
@property (nonatomic, strong) MaxTempView       *maxTempView;
@property (nonatomic, strong) SunInfoView       *sunInfoView;
@property (nonatomic, strong) TemperatureView   *temperatureView;

@property (nonatomic, strong) UITableView       *tableView;

@end

@implementation WeatherView

- (void)buildView {
    
    
    // 加载用tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];

    // 湿度控件
    self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(15, 250, 140, 140)];
    [self.humidityView buildView];
    [self.tableView addSubview:self.humidityView];
    
    // 风速控件
    self.windSpeedView = [[WindSpeedView alloc] initWithFrame:CGRectMake(165, 250, 140, 140)];
    [self.windSpeedView buildView];
    [self.tableView addSubview:self.windSpeedView];
    
    // 最高温 - 最低温控件
    self.maxTempView = [[MaxTempView alloc] initWithFrame:CGRectMake(15, 405, 140, 140)];
    [self.maxTempView buildView];
    [self.tableView addSubview:self.maxTempView];
    
    // 日出 - 日落信息控件
    self.sunInfoView = [[SunInfoView alloc] initWithFrame:CGRectMake(165, 405, 140, 140)];
    [self.sunInfoView buildView];
    [self.tableView addSubview:self.sunInfoView];
    
    // 温度控件
    self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(165, 95, 140, 140)];
    [self.temperatureView buildView];
    [self.tableView addSubview:self.temperatureView];
    
    
    // 标题
    self.titleView = [[WeatherTitleView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.titleView buildView];
    [self addSubview:self.titleView];
}

/**
 *  显示动画
 */
- (void)show {
    
    if (self.weahterData == nil) {
        return;
    }
    
    // 湿度显示
    self.humidityView.percent = self.weahterData.main.humidity.intValue / 100.f;
    
    
    // 风速显示
    self.windSpeedView.windSpeed         = self.weahterData.wind.speed.floatValue;
    self.windSpeedView.circleByOneSecond = self.windSpeedView.windSpeed / 5.f;
    
    
    // 最大温度,最小温度显示
    CGFloat tmpMax = self.weahterData.main.temp_max.floatValue - 273.15;
    CGFloat tmpMin = self.weahterData.main.temp_min.floatValue - 273.15;
    self.maxTempView.maxTemp = tmpMax;
    self.maxTempView.minTemp = tmpMin;

    
    // 日出时间,日落时间显示
    self.sunInfoView.sunsireValue.utcSec = self.weahterData.sys.sunrise.integerValue;
    [self.sunInfoView.sunsireValue accessUtcSec];
    self.sunInfoView.sunsetValue.utcSec = self.weahterData.sys.sunset.integerValue;
    [self.sunInfoView.sunsetValue accessUtcSec];
    
    
    // 当前温度显示(开尔文温度 --> 热力学温度)
    self.temperatureView.temperature = self.weahterData.main.temp.floatValue - 273.15;
    
    // 更新标题信息
    self.titleView.cityName = self.weahterData.name;
    Weather *weather = self.weahterData.weather[0];
    self.titleView.weatherDescription = weather.descriptionInfo;
    
    
    [self.windSpeedView show];
    [self.humidityView show];
    [self.maxTempView show];
    [self.sunInfoView show];
    [self.temperatureView show];
    [self.titleView show];
}



- (void)hide {
    // 湿度隐藏
    [self.humidityView hide];
    
    // 风速隐藏
    [self.windSpeedView hide];
    
    // 最大温度,最小温度隐藏
    [self.maxTempView hide];
    
    // 日出时间,日落时间显示
    [self.sunInfoView hide];
    
    // 当前温度
    [self.temperatureView hide];
    
    // 隐藏标题
    [self.titleView hide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= 0) {
        CGFloat percent = -offsetY / 100.f;
        [self.changeColorLabel colorPercent:percent];
        
        CGFloat tmpX  = - offsetY;
        
        self.hLine.x  = 17.f + tmpX * 0.2;
        self.vLine.y  = 18.f + tmpX *0.1f;
        self.changeColorLabel.x = 35 + tmpX * 0.1;
        
    } else {
        CGFloat percent = 50 - offsetY;
        self.changeColorLabel.alpha = percent / 50.f;
    }
}


@end
