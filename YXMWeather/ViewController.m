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
#import "WeatherIconView.h"

#import "ChangeColorLabel.h"
#import "LoadingView.h"



#import "WeatherView.h"
#import "CurrentWeatherData.h"
#import "CurrentConditions.h"
#import "CityTitleView.h"


#import "TitleMoveLabel.h"
#import "LongTapAnimationView.h"


#import "GetWeatherData.h"


// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)


@interface ViewController ()<MapManagerLocationDelegate, UITableViewDelegate, GetWeatherDataDelegate>


@property (nonatomic, strong) MapManager   *mapLoacation;


@property (nonatomic, strong) HumidityView      *humidityView;
@property (nonatomic, strong) WindSpeedView     *windSpeedView;
@property (nonatomic, strong) MaxTempView       *maxTempView;
@property (nonatomic, strong) SunInfoView       *sunInfoView;
@property (nonatomic, strong) TemperatureView   *temperatureView;
@property (nonatomic, strong) WeatherIconView   *weatherIconView;


@property (nonatomic, strong) UIButton          *testButton;
@property (nonatomic)         BOOL               isShow;


@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIView            *lineView;


@property (nonatomic, strong) ChangeColorLabel  *changeColorLabel;
@property (nonatomic, strong) UIView            *vLine;
@property (nonatomic, strong) UIView            *hLine;
@property (nonatomic, strong) LoadingView       *loadingView;



@property (nonatomic, strong) WeatherView       *weatherView;



@property (nonatomic, strong) CityTitleView     *cityTitleView;


@property (nonatomic, strong) GetWeatherData    *getWeatherData;



@property (nonatomic, strong) UIButton          *button;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 测试背景图
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    bgImageView.image = [UIImage imageNamed:@"BG"];
//    [self.view addSubview:bgImageView];
//
//    
//    
//    if (iPhone5_5s) {
//        NSLog(@"苹果5s");
//    } else if (iPhone6) {
//        NSLog(@"iphone6");
//    } else if (iPhone6_plus) {
//        NSLog(@"iphone6_plus");
//    } else if (iPhone4_4s){
//        NSLog(@"苹果4");
//    }
    
    
    
#if 0
    // 测试用tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
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

    
    self.cityTitleView = [[CityTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 100)];
    [self.cityTitleView buildView];
    [self.tableView addSubview:self.cityTitleView];

    
    
    // 创建测试按钮
    [self createTestButton];
    
    
    [Networking GET:@"http://api.openweathermap.org/data/2.5/forecast/daily"
         parameters:@{@"lat"  : @"39.88293652833437",
                      @"lon"  : @"116.4621119300779",
                      @"cnt"  : @"10"}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@", responseObject);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@", error);
            }];
    
    
    [Networking GET:@"http://api.openweathermap.org/data/2.5/weather"
         parameters: @{@"lat"  : @"39.88293652833437",
                       @"lon"  : @"116.4621119300779",}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"\n\n\n\n\n\n----------\n%@\n\n\n\n\n\n\n\n", responseObject);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
    
    
    
    // 获取10天天气
    // http://api.openweathermap.org/data/2.5/forecast/daily?lat=39.907501&lon=116.397232&cnt=10


#endif

    // 天气的view
    self.weatherView = [[WeatherView alloc] initWithFrame:self.view.bounds];
    [self.weatherView buildView];
    [self.view addSubview:self.weatherView];


    // 定位功能
    self.mapLoacation          = [MapManager new];
    self.mapLoacation.delegate = self;
    [self.mapLoacation start];
    
    
    // 获取网络请求
    self.getWeatherData          = [GetWeatherData new];
    self.getWeatherData.delegate = self;
    
    
    // 测试用按钮
    self.button = [[UIButton alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.button];
    [self.button addTarget:self
                    action:@selector(myButtonEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    self.button.userInteractionEnabled = NO;

}

- (void)myButtonEvent:(UIButton *)button {
    self.button.userInteractionEnabled = NO;
    [self.mapLoacation start];
}

- (void)weatherData:(id)object sucess:(BOOL)sucess {
    if (sucess) {
        NSLog(@"%@", object);
        
        
        // 获取数据
        CurrentWeatherData *data       = [object valueForKey:@"WeatherData"];
        CurrentConditions  *conditions = [object valueForKey:@"WeatherConditions"];
        
        // 先获取温度
        self.weatherView.weahterData       = data;
        self.weatherView.weatherConditions = conditions;
        
        // 先隐藏,再显示
        [self.weatherView hide];
        [GCDQueue executeInMainQueue:^{
            [self.weatherView show];
        } afterDelaySecs:1.f];
        
        [GCDQueue executeInMainQueue:^{
            self.button.userInteractionEnabled = YES;
        } afterDelaySecs:1.f + 2.f];
    } else {
        NSLog(@"获取数据失败");
        self.button.userInteractionEnabled = YES;
    }
}

- (void)mapManager:(MapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location {
    // 过滤掉重复的地址
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(delayRunEvent:)
               withObject:location
               afterDelay:0.3f];
}

/**
 *  延时执行
 *
 *  @param object 过滤掉干扰项目
 */
- (void)delayRunEvent:(id)object {
    self.getWeatherData.location = object;
    [self.getWeatherData startGetLocationWeatherData];
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
        
        
        // 风速显示
        self.windSpeedView.windSpeed         = arc4random() % 400;
        self.windSpeedView.circleByOneSecond = self.windSpeedView.windSpeed / 300.f;

        
        // 最大温度,最小温度显示
        CGFloat tmpMax = arc4random() % 40;
        CGFloat tmpMin = arc4random() % 20;
        self.maxTempView.maxTemp = tmpMax;
        self.maxTempView.minTemp = tmpMin;

        
        // 日出时间,日落时间显示
        self.sunInfoView.sunsireValue.utcSec = 1424473131 + arc4random() % 2000;
        [self.sunInfoView.sunsireValue accessUtcSec];
        self.sunInfoView.sunsetValue.utcSec = 1424512601 + arc4random() % 2000;
        [self.sunInfoView.sunsetValue accessUtcSec];
//        NSLog(@"%@", self.sunInfoView.sunsireValue.timeString);
//        NSLog(@"%@", self.sunInfoView.sunsetValue.timeString);

        
        // 当前温度显示
        self.temperatureView.temperature = 17;


        
        
        [self.windSpeedView show];
        [self.maxTempView show];
        [self.sunInfoView show];
        [self.temperatureView show];
        [self.humidityView show];
        [self.weatherIconView show];

        
        
        
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
        
        [self.weatherIconView hide];
        
        
        [GCDQueue executeInMainQueue:^{
            button.userInteractionEnabled = YES;
        } afterDelaySecs:0.76];
    }
}

@end
