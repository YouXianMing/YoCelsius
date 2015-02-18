//
//  ViewController.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "ViewController.h"
#import "MapManager.h"
#import "LabelView.h"
#import "FrameView.h"
#import "CircleView.h"
#import "HumidityView.h"
#import "RotatedAngleView.h"

@interface ViewController ()<MapManagerLocationDelegate>

@property (nonatomic, strong) MapManager   *mapLoacation;
@property (nonatomic ,strong) HumidityView *humidityView;

@property (nonatomic, strong) RotatedAngleView *rotatedView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试背景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:imageView];
    

    self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(150, 225, 100, 100)];
    [self.humidityView buildView];
    [self.view addSubview:self.humidityView];


    
    [GCDQueue executeInMainQueue:^{
        self.humidityView.percent = 0.6;
        [self.humidityView show];
    } afterDelaySecs:1.];
    
    
    [GCDQueue executeInMainQueue:^{
        [self.humidityView hide];
    } afterDelaySecs:4.f];
    
    
    [GCDQueue executeInMainQueue:^{
        self.humidityView.percent = 0.9;
        [self.humidityView show];
    } afterDelaySecs:7.f];

}

@end
