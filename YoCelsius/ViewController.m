//
//  ViewController.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/15.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ViewController.h"

// 管理定位的view
#import "MapManager.h"

// 天气的view
#import "WeatherView.h"
#import "SearchView.h"

// 网络Model数据
#import "CurrentWeatherData.h"
#import "CurrentConditions.h"

// 获取网络数据
#import "GetWeatherData.h"

// 控制器
#import "ForecastController.h"

// 动画生成器
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"

// 更新 + 变黑
#import "UpdatingView.h"
#import "FadeBlackView.h"

#import "FailedLongPressView.h"
#import "TWMessageBarManager.h"

// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

@interface ViewController ()<MapManagerLocationDelegate, UITableViewDelegate, GetWeatherDataDelegate, WeatherViewDelegate, UIViewControllerTransitioningDelegate, FailedLongPressViewDelegate>

@property (nonatomic, strong) MapManager           *mapLoacation;
@property (nonatomic, strong) WeatherView          *weatherView;
@property (nonatomic, strong) GetWeatherData       *getWeatherData;
@property (nonatomic, strong) FadeBlackView        *fadeBlackView;
@property (nonatomic, strong) UpdatingView         *upDatingView;

@property (nonatomic, strong) FailedLongPressView  *failedView;  // 加载失败后显示的view

@property (nonatomic)         BOOL                  firstTimeLoadingData;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 获取10天天气
    // http://api.openweathermap.org/data/2.5/forecast/daily?lat=39.907501&lon=116.397232&cnt=10
    
    // 天气的view
    self.weatherView                     = [[WeatherView alloc] initWithFrame:self.view.bounds];
    self.weatherView.layer.masksToBounds = YES;
    self.weatherView.delegate            = self;
    [self.weatherView buildView];
    [self.view addSubview:self.weatherView];
    
    // 变黑
    self.fadeBlackView = [[FadeBlackView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.fadeBlackView];
    
    // loading
    self.upDatingView        = [[UpdatingView alloc] initWithFrame:CGRectZero];
    self.upDatingView.center = self.view.center;
    [self.view addSubview:self.upDatingView];
    
    // 定位功能
    self.mapLoacation          = [MapManager new];
    self.mapLoacation.delegate = self;
    
    // 获取网络请求
    self.getWeatherData          = [GetWeatherData new];
    self.getWeatherData.delegate = self;
    
    // 加载失败后显示的view
    self.failedView          = [[FailedLongPressView alloc] initWithFrame:self.view.bounds];
    self.failedView.delegate = self;
    [self.failedView buildView];
    [self.view addSubview:self.failedView];
    
    // 进入加载数据动画效果
    [self getLocationAndFadeShow];
}

/**
 *  上拉进入新的控制器
 *
 *  @param condition 新控制器需要的数据
 */
- (void)pullUpEventWithData:(CurrentConditions *)condition {
    
    [GCDQueue executeInMainQueue:^{
        
        ForecastController *forecastCV    = [ForecastController new];
        forecastCV.transitioningDelegate  = self;
        forecastCV.modalPresentationStyle = UIModalPresentationCustom;
        forecastCV.weatherCondition       = condition;
        
        [self presentViewController:forecastCV
                           animated:YES
                         completion:^{}];
        
    } afterDelaySecs:0.05f];
}

/**
 *  下拉更新数据
 */
- (void)pullDownToRefreshData {
    
    NSLog(@"下拉获取数据");
    [self getLocationAndFadeShow];
}

- (void)getLocationAndFadeShow {
    
    // 显示出等待页面
    [self.fadeBlackView show];
    [self.upDatingView show];
    
    // 开始定位
    [self.mapLoacation start];
}

- (void)getCityIdAndFadeShow {
    
    // 显示出等待页面
    [self.fadeBlackView show];
    [self.upDatingView show];
}

- (void)mapManager:(MapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location {
    
    NSLog(@"定位成功 - 并开始获取网路数据");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(delayRunEvent:)
               withObject:location
               afterDelay:0.3f];
}

- (void)mapManager:(MapManager *)manager didFailed:(NSError *)error {
    
    NSLog(@"定位失败");
    [self.upDatingView showFailed];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.fadeBlackView hide];
        [self.upDatingView hide];
        
    } afterDelaySecs:2.5f];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.failedView show];
        
    } afterDelaySecs:2.5f];
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Failed to locate"
                                                       description:@"Sorry, temporarily unable to locate your position."
                                                              type:TWMessageBarMessageTypeError
                                                          callback:^{}];
        
    } afterDelaySecs:1.f];
}

- (void)mapManagerServerClosed:(MapManager *)manager {
    
    [GCDQueue executeInMainQueue:^{
        
        [self.fadeBlackView hide];
        [self.upDatingView hide];
        
    } afterDelaySecs:1.5];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.failedView show];
        
    } afterDelaySecs:1.5f];
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Failed to locate"
                                                       description:@"Please turn on your Locations Service."
                                                              type:TWMessageBarMessageTypeError
                                                          callback:^{}];
        
    } afterDelaySecs:0.f];
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

/**
 *  获取到网络数据的结果
 *
 *  @param object 网络数据
 *  @param sucess YES表示成功,NO表示失败
 */
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
            [self.fadeBlackView hide];
            [self.upDatingView hide];
            
        } afterDelaySecs:1.f];
        
        [GCDQueue executeInMainQueue:^{
            
            [self.failedView remove];
            
        } afterDelaySecs:1.f];
        
    } else {
        NSLog(@"获取数据失败");
        
        [self.upDatingView showFailed];
        [GCDQueue executeInMainQueue:^{
            
            [self.fadeBlackView hide];
            [self.upDatingView hide];
            
        } afterDelaySecs:2.51f];
        
        
        [GCDQueue executeInMainQueue:^{
            
            [self.failedView show];
            
        } afterDelaySecs:2.51f];
        
        [self showErrorInfo];
    }
}

- (void)showErrorInfo {
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Network Unreachable"
                                                       description:@"Please try later."
                                                              type:TWMessageBarMessageTypeError
                                                          callback:^{}];
        
    } afterDelaySecs:1.f];
}


- (void)pressEvent:(FailedLongPressView *)view {
    
    [self.failedView hide];
    [self getLocationAndFadeShow];
}

#pragma mark - 定制转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    // 推出控制器的动画
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    // 退出控制器动画
    return [DismissingAnimator new];
}

@end
