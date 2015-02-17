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

@interface ViewController ()<MapManagerLocationDelegate>

@property (nonatomic, strong) MapManager *mapLoacation;
@property (nonatomic, strong) GCDTimer   *timer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CircleView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试背景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:imageView];
    
//    [self produceCircleShapeLayer];
    
    self.circleView            = [[CircleView alloc] initWithFrame:CGRectMake(100, 100, 70, 70)];
    self.circleView.lineWidth  = 5;
    self.circleView.lineColor  = [UIColor blackColor];
    self.circleView.clockWise  = YES;
    self.circleView.startAngle = 200;
    [self.circleView buildView];
    [self.view addSubview:self.circleView];
    
    [GCDQueue executeInMainQueue:^{
        [self.circleView strokeEnd:0.8 animated:YES duration:1.5];
    } afterDelaySecs:1.f];
    
    [GCDQueue executeInMainQueue:^{
        [self.circleView strokeEnd:0.f animated:YES duration:1.5];
    } afterDelaySecs:5.f];
}

@end
