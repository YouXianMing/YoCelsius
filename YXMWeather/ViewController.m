//
//  ViewController.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "ViewController.h"
#import "MapManager.h"

@interface ViewController ()<MapManagerLocationDelegate>

@property (nonatomic, strong) MapManager *mapLoacation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_WHITE;
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WxHxD_Width, WxHxD_Height - 400)];
    [self.view addSubview:testView];
    testView.backgroundColor = COLOR_CYAN;

    UILabel *you = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WxHxD_Width - 30, 40)];
    you.textColor = [UIColor redColor];
    you.text = @"YouXianMing";
    [self.view addSubview:you];
    
    
    
    
    
    
//    self.mapLoacation          = [MapManager new];
//    self.mapLoacation.delegate = self;
//    
//    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:button];
//    
//    [button addTarget:self
//               action:@selector(buttonEvent)
//     forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonEvent {
    [self.mapLoacation start];
    NSLog(@"%d", self.mapLoacation.authorizationStatus);
}

- (void)mapManager:(MapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location {
    NSLog(@"%@", location);
}
- (void)mapManager:(MapManager *)manager didFailed:(NSError *)error {
//    NSLog(@"%d", manager.authorizationStatus);
}



@end
