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
#import "WeatherIconView.h"
#import "TemperatureView.h"

#import "ChangeColorLabel.h"
#import "CityTitleView.h"

@interface WeatherView ()<UITableViewDelegate>



@property (nonatomic, strong) ChangeColorLabel  *changeColorLabel;
@property (nonatomic, strong) UIView            *vLine;
@property (nonatomic, strong) UIView            *hLine;



@property (nonatomic ,strong) HumidityView      *humidityView;
@property (nonatomic, strong) WindSpeedView     *windSpeedView;
@property (nonatomic, strong) MaxTempView       *maxTempView;
@property (nonatomic, strong) SunInfoView       *sunInfoView;
@property (nonatomic, strong) TemperatureView   *temperatureView;
@property (nonatomic, strong) WeatherIconView   *weatherIconView;

@property (nonatomic, strong) CityTitleView     *cityTitleView;


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
    
    // 显示控件
    self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
    [self.humidityView buildView];
    [self.tableView addSubview:self.humidityView];
    
    
    self.windSpeedView = [[WindSpeedView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
    [self.windSpeedView buildView];
    [self.tableView addSubview:self.windSpeedView];
    
    
    self.maxTempView = [[MaxTempView alloc] initWithFrame:CGRectMake(0, Height - Width, Width / 2.f, Width / 2.f)];
    [self.maxTempView buildView];
    [self.tableView addSubview:self.maxTempView];
    
    
    self.sunInfoView = [[SunInfoView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width, Width / 2.f, Width / 2.f)];
    [self.sunInfoView buildView];
    [self.tableView addSubview:self.sunInfoView];
    
    self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
    [self.temperatureView buildView];
    [self.tableView addSubview:self.temperatureView];
    
    
    self.weatherIconView = [[WeatherIconView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
    [self.weatherIconView buildView];
    [self.tableView addSubview:self.weatherIconView];
    
    
    
    // 创建出线条
    {
        UIView *grayLine1         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width, 1)];
        grayLine1.backgroundColor = [UIColor blackColor];
        grayLine1.alpha           = 0.1;
        [self.tableView addSubview:grayLine1];
        
        UIView *grayLine2         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 1, Width, 1)];
        grayLine2.backgroundColor = [UIColor blackColor];
        grayLine2.alpha           = 0.1;
        [self.tableView addSubview:grayLine2];
        
        UIView *grayLine3         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width, Width, 1)];
        grayLine3.backgroundColor = [UIColor blackColor];
        grayLine3.alpha           = 0.1;
        [self.tableView addSubview:grayLine3];
        
        UIView *grayLine4         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width, 1)];
        grayLine4.backgroundColor = [UIColor blackColor];
        grayLine4.alpha           = 0.1;
        [self.tableView addSubview:grayLine4];
        
        UIView *vLine             = [[UIView alloc] initWithFrame:CGRectMake(Width / 2.f - 1, Height - Width - Width / 2.f, 1, Width + Width / 2.f)];
        vLine.backgroundColor     = [UIColor blackColor];
        vLine.alpha               = 0.1;
        [self.tableView addSubview:vLine];
    }


    // 标题
    self.cityTitleView = [[CityTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - Width - Width / 2.f)];
    [self.cityTitleView buildView];
    [self addSubview:self.cityTitleView];
}

/**
 *  显示动画
 */
- (void)show {
    
    if (self.weahterData == nil) {
        return;
    }
    
    
    
//    // 显示当中
//    _isHidingOrShowingStatus = YES;
//    NSLog(@"%@", NSStringFromCGPoint(_tableView.contentOffset));
//    _tableView.panGestureRecognizer.enabled = NO;
//    NSLog(@"%@", NSStringFromCGPoint(_tableView.contentOffset));
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [GCDQueue executeInMainQueue:^{
//        _isHidingOrShowingStatus = NO;
//        _tableView.panGestureRecognizer.enabled = YES;
//    } afterDelaySecs:1.76];
    
    
    
    // 湿度显示
    self.humidityView.percent = self.weahterData.main.humidity.intValue / 100.f;
    
    
    // 风速显示
    self.windSpeedView.windSpeed         = self.weahterData.wind.speed.floatValue;
    self.windSpeedView.circleByOneSecond = self.windSpeedView.windSpeed / 5.f;
    
    
    // 最大温度,最小温度显示
    WeatherInfo *today = self.weatherConditions.list[0];
    CGFloat tmpMax = today.temp.max.floatValue - 273.15;
    CGFloat tmpMin = today.temp.min.floatValue - 273.15;
    self.maxTempView.maxTemp = tmpMax;
    self.maxTempView.minTemp = tmpMin;
    
    
    // 日出时间,日落时间显示
    self.sunInfoView.sunsireValue.utcSec = self.weahterData.sys.sunrise.integerValue;
    [self.sunInfoView.sunsireValue accessUtcSec];
    self.sunInfoView.sunsetValue.utcSec = self.weahterData.sys.sunset.integerValue;
    [self.sunInfoView.sunsetValue accessUtcSec];
    
    
    // 当前温度显示(开尔文温度 --> 热力学温度)
    self.temperatureView.temperature = self.weahterData.main.temp.floatValue - 273.15;

    
    // 开始标题动画
    self.cityTitleView.cityName = self.weahterData.name; // 城市名字
    Weather *weather = self.weahterData.weather[0];
    self.cityTitleView.weatherDescription = weather.descriptionInfo; // 天气描述信息
    self.cityTitleView.baseStation = self.weahterData.base; // 基站信息
    self.cityTitleView.utcSec      = self.weahterData.dt.integerValue; // 更新时间
    
    NSDate *utcDate = [NSDate dateWithTimeIntervalSince1970:self.weahterData.dt.integerValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy:MM:dd hh:mm a EEEE MMMM dd"];
    NSLog(@"数据更新时间 ===   %@", [formatter stringFromDate:utcDate]);
    [formatter setDateFormat:@"yyyy.mm.dd"];
    NSLog(@"数据更新时间 ===   %@", [formatter stringFromDate:utcDate]);
    [formatter setDateFormat:@"hh:mm"];
    NSLog(@"数据更新时间 ===   %@", [formatter stringFromDate:utcDate]);
    
    
    [self.windSpeedView show];
    [self.humidityView show];
    [self.maxTempView show];
    [self.sunInfoView show];
    [self.temperatureView show];
    [self.weatherIconView show];
    [self.cityTitleView show];
}



- (void)hide {
    
    
    
//    // 显示当中
//    _isHidingOrShowingStatus = YES;
//    _tableView.panGestureRecognizer.enabled = NO;
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [GCDQueue executeInMainQueue:^{
//        _isHidingOrShowingStatus = NO;
//        _tableView.panGestureRecognizer.enabled = YES;
//    } afterDelaySecs:0.76];

    
    
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
    
    // 当前温度图标
    [self.weatherIconView hide];
    
    // 隐藏标题动画
    [self.cityTitleView hide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.label.y = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 位移超过100后执行动画效果
    
    
//    if (scrollView.contentOffset.y >= 100) {
//        
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        
//        
//        CGPoint startPoint = self.tableView.center;
//        CGPoint endPoint   = CGPointMake(self.tableView.middleX, self.tableView.middleY - Height);
//        
//        
//        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
//        keyAnimation.keyPath              = @"position";
//        keyAnimation.values               = [YXEasing calculateFrameFromPoint:startPoint
//                                                                      toPoint:endPoint
//                                                                         func:CubicEaseIn
//                                                                   frameCount:1.f * 30.f];
//        keyAnimation.duration             = 1.f;
//        [self.tableView.layer addAnimation:keyAnimation forKey:nil];
//        
//        
//        // 执行透明度动画
//        [UIView animateWithDuration:0.95 animations:^{
//            self.tableView.alpha = 0.f;
//        }];
//        
//        
//        [GCDQueue executeInMainQueue:^{
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            self.tableView.alpha = 1.f;
//        } afterDelaySecs:1.1];
//    }
}

@end
