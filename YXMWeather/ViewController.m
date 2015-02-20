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


#import "AlphaView.h"


// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)


@interface ViewController ()<MapManagerLocationDelegate>

@property (nonatomic, strong) MapManager   *mapLoacation;

@property (nonatomic ,strong) HumidityView  *humidityView;
@property (nonatomic, strong) WindSpeedView *windSpeedView;


@property (nonatomic, strong) UIButton  *testButton;
@property (nonatomic)         BOOL       isShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试背景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:imageView];
    

    self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(45, 200, 100, 100)];
    [self.humidityView buildView];
    [self.view addSubview:self.humidityView];
    
    
    self.windSpeedView = [[WindSpeedView alloc] initWithFrame:CGRectMake(38, 240 + 140, 80, 80)];
    [self.windSpeedView buildView];
    [self.view addSubview:self.windSpeedView];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(170, 200, 1, 100 * 0.75)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(170, 250, 125 * 0.75, 1)];
    lineTwo.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineTwo];
    
    
//    [Networking GET:@"http://api.openweathermap.org/data/2.5/weather"
//         parameters: @{@"lat"  : @"39.88293652833437",
//                       @"lon"  : @"116.4621119300779"}
//            success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"%@", responseObject);
//            }
//            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//            }];
 
    
    // 创建测试按钮
    [self createTestButton];
}

- (void)createTestButton {
    self.testButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    [self.testButton addTarget:self
                        action:@selector(buttonEvent:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
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
        
        [GCDQueue executeInMainQueue:^{
            button.userInteractionEnabled = YES;
        } afterDelaySecs:1.6];
    } else {
        self.isShow = NO;
        
        // 湿度隐藏
        [self.humidityView hide];
        
        // 风速隐藏
        [self.windSpeedView hide];
        
        [GCDQueue executeInMainQueue:^{
            button.userInteractionEnabled = YES;
        } afterDelaySecs:0.76];
    }
}

@end
