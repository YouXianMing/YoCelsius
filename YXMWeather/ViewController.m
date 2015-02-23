//
//  ViewController.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "ViewController.h"
#import "MapManager.h"

#import "HumidityView.h"
#import "WindSpeedView.h"
#import "MaxTempView.h"
#import "SunInfoView.h"
#import "TemperatureView.h"

#import "ChangeColorLabel.h"
#import "LoadingView.h"



#import "WeatherView.h"
#import "CurrentWeatherData.h"


// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)


@interface ViewController ()<MapManagerLocationDelegate, UITableViewDelegate>


@property (nonatomic, strong) MapManager   *mapLoacation;


@property (nonatomic ,strong) HumidityView      *humidityView;
@property (nonatomic, strong) WindSpeedView     *windSpeedView;
@property (nonatomic, strong) MaxTempView       *maxTempView;
@property (nonatomic, strong) SunInfoView       *sunInfoView;
@property (nonatomic, strong) TemperatureView   *temperatureView;


@property (nonatomic, strong) UIButton          *testButton;
@property (nonatomic)         BOOL               isShow;


@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIView            *lineView;


@property (nonatomic, strong) ChangeColorLabel  *changeColorLabel;
@property (nonatomic, strong) UIView            *vLine;
@property (nonatomic, strong) UIView            *hLine;
@property (nonatomic, strong) LoadingView       *loadingView;



@property (nonatomic, strong) WeatherView       *weatherView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 测试背景图
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    bgImageView.image = [UIImage imageNamed:@"BG副本副本"];
//    [self.view addSubview:bgImageView];
    
    
    
#if 0
    // 测试用tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    
    // 颜色设置
    self.changeColorLabel              = [[ChangeColorLabel alloc] initWithFrame:CGRectMake(35, 23, 0, 0)];
    self.changeColorLabel.text         = @"San FranCisco";
    self.changeColorLabel.textColor    = [UIColor blackColor];
    self.changeColorLabel.changedColor = COLOR_PURE_;
    self.changeColorLabel.font         = [UIFont fontWithName:LATO_REGULAR size:24];
    [self.changeColorLabel updateLabelView];
    [self.changeColorLabel colorPercent:0.f];
    [self.view addSubview:self.changeColorLabel];
    
    self.vLine = [[UIView alloc] initWithFrame:CGRectMake(17, 18, 6, 40)];
    self.vLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.vLine];
    
    self.hLine = [[UIView alloc] initWithFrame:CGRectMake(self.vLine.x, self.vLine.y + self.vLine.height, 200, 1)];
    self.hLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.hLine];
    
    
//    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCircle"]];
//    imageView2.x = 100;
//    imageView2.y = 100;
//    imageView2.alpha = 0.5f;
//    [self.tableView addSubview:imageView2];
//    
//    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pureCircle"]];
//    imageView1.x = 100;
//    imageView1.y = 100;
//    [self.tableView addSubview:imageView1];
    
    
    
    self.loadingView      = [[LoadingView alloc] initWithFrame:CGRectMake(250, 20, 43, 43)];
    self.loadingView.staticCircleImage = [UIImage imageNamed:@"blackCircle"];
    self.loadingView.animtedImage      = [UIImage imageNamed:@"pureCircle"];
    [self.view addSubview:self.loadingView];
    




    
//    [UIView animateWithDuration:2 animations:^{
//        imageView1.transform = CGAffineTransformRotate(imageView1.transform, RADIAN(180));
//    } completion:^(BOOL finished) {
//        NSLog(@"kkkkk");
//    }];
    
    
    
    // 显示控件
    self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(15, 250, 140, 140)];
    [self.humidityView buildView];
    [self.tableView addSubview:self.humidityView];
    
    
    self.windSpeedView = [[WindSpeedView alloc] initWithFrame:CGRectMake(165, 250, 140, 140)];
    [self.windSpeedView buildView];
    [self.tableView addSubview:self.windSpeedView];
    
    
    self.maxTempView = [[MaxTempView alloc] initWithFrame:CGRectMake(15, 405, 140, 140)];
    [self.maxTempView buildView];
    [self.tableView addSubview:self.maxTempView];
    

    self.sunInfoView = [[SunInfoView alloc] initWithFrame:CGRectMake(165, 405, 140, 140)];
    [self.sunInfoView buildView];
    [self.tableView addSubview:self.sunInfoView];
    
    
    self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(165, 95, 140, 140)];
    [self.temperatureView buildView];
    [self.tableView addSubview:self.temperatureView];


    
    
    // 创建测试按钮
    [self createTestButton];

#endif

    
    self.weatherView = [[WeatherView alloc] initWithFrame:self.view.bounds];
    [self.weatherView buildView];
    [self.view addSubview:self.weatherView];
    

    [Networking GET:@"http://api.openweathermap.org/data/2.5/weather"
         parameters: @{@"lat"  : @"39.88293652833437",
                       @"lon"  : @"116.4621119300779"}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@", responseObject);
                CurrentWeatherData *weatherData = [[CurrentWeatherData alloc] initWithDictionary:responseObject];
                // 显示
                if (weatherData.cod.intValue == 200) {
                    
                    // 先获取温度
                    self.weatherView.weahterData = weatherData;
                    
                    // 再显示
                    [self.weatherView show];
                    
                    
                    [GCDQueue executeInMainQueue:^{
                        [self.weatherView hide];
                    } afterDelaySecs:4.f];
                    
                    
                    [GCDQueue executeInMainQueue:^{
                        [self.weatherView show];
                    } afterDelaySecs:7.f];
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
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
        
        
        if (percent >= 1) {
            [self.loadingView show];
        }
    } else {
        CGFloat percent = 50 - offsetY;
        NSLog(@"%f", percent);
        self.changeColorLabel.alpha = percent / 50.f;
        
        
        if (offsetY > 100) {
            [self.loadingView hide];
        }
    }
}

- (void)createTestButton {
    self.testButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    [self.testButton addTarget:self
                        action:@selector(buttonEvent:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.testButton];
}

- (void)buttonEvent:(UIButton *)button {
    button.userInteractionEnabled = NO;
    
    if (self.isShow == NO) {
        self.isShow = YES;
        
        // 湿度显示
        self.humidityView.percent = (arc4random() % 100 / 100.f);
        [self.humidityView show];
        
        // 风速显示
        self.windSpeedView.windSpeed         = arc4random() % 400;
        self.windSpeedView.circleByOneSecond = self.windSpeedView.windSpeed / 300.f;
        [self.windSpeedView show];
        
        // 最大温度,最小温度显示
        CGFloat tmpMax = arc4random() % 40;
        CGFloat tmpMin = arc4random() % 20;
        self.maxTempView.maxTemp = tmpMax;
        self.maxTempView.minTemp = tmpMin;
        [self.maxTempView show];
        
        // 日出时间,日落时间显示
        self.sunInfoView.sunsireValue.utcSec = 1424473131 + arc4random() % 2000;
        [self.sunInfoView.sunsireValue accessUtcSec];
        self.sunInfoView.sunsetValue.utcSec = 1424512601 + arc4random() % 2000;
        [self.sunInfoView.sunsetValue accessUtcSec];
        NSLog(@"%@", self.sunInfoView.sunsireValue.timeString);
        NSLog(@"%@", self.sunInfoView.sunsetValue.timeString);
        [self.sunInfoView show];
        
        // 当前温度显示
        self.temperatureView.temperature = 17;
        [self.temperatureView show];
        
        
        
        [GCDQueue executeInMainQueue:^{
            button.userInteractionEnabled = YES;
        } afterDelaySecs:1.6];
        
        
    } else {
        self.isShow = NO;
        
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
        
        
        [GCDQueue executeInMainQueue:^{
            button.userInteractionEnabled = YES;
        } afterDelaySecs:0.76];
    }
}

@end
