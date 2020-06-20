//
//  ViewController.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/15.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherInfoController.h"
#import "MapManager.h"
#import "WeatherView.h"
#import "CurrentWeatherData.h"
#import "CurrentConditions.h"
#import "GetWeatherData.h"
#import "ForecastController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "UpdatingView.h"
#import "FadeBlackView.h"
#import "FailedLongPressView.h"
#import "TWMessageBarManager.h"

@interface WeatherInfoController ()<MapManagerLocationDelegate, UITableViewDelegate, GetWeatherDataDelegate, WeatherViewDelegate, UIViewControllerTransitioningDelegate, FailedLongPressViewDelegate>

@property (nonatomic, strong) MapManager           *mapLoacation;
@property (nonatomic, strong) WeatherView          *weatherView;
@property (nonatomic, strong) GetWeatherData       *getWeatherData;
@property (nonatomic, strong) FadeBlackView        *fadeBlackView;
@property (nonatomic, strong) UpdatingView         *upDatingView;
@property (nonatomic, strong) FailedLongPressView  *failedView;
@property (nonatomic)         BOOL                  firstTimeLoadingData;

@end

@implementation WeatherInfoController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.weatherView                     = [[WeatherView alloc] initWithFrame:self.view.bounds];
    self.weatherView.layer.masksToBounds = YES;
    self.weatherView.delegate            = self;
    [self.weatherView buildView];
    [self.view addSubview:self.weatherView];
    
    self.fadeBlackView = [[FadeBlackView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.fadeBlackView];
    
    self.upDatingView        = [[UpdatingView alloc] initWithFrame:CGRectZero];
    self.upDatingView.center = self.view.center;
    [self.view addSubview:self.upDatingView];
    
    self.mapLoacation          = [MapManager new];
    self.mapLoacation.delegate = self;
    
    self.getWeatherData          = [GetWeatherData new];
    self.getWeatherData.delegate = self;
    
    self.failedView          = [[FailedLongPressView alloc] initWithFrame:self.view.bounds];
    self.failedView.delegate = self;
    [self.failedView buildView];
    [self.view addSubview:self.failedView];
    
    [self getLocationAndFadeShow];
}

- (void)pullUpEventWithData:(CurrentConditions *)condition {
    
    [GCDQueue executeInMainQueue:^{
        
        ForecastController *forecastCV    = [ForecastController new];
        forecastCV.transitioningDelegate  = self;
        forecastCV.modalPresentationStyle = UIModalPresentationCustom;
        forecastCV.weatherCondition       = condition;
        [self presentViewController:forecastCV animated:YES completion:nil];
        
    } afterDelaySecs:0.05f];
}

- (void)pullDownToRefreshData {
    
    [self getLocationAndFadeShow];
}

- (void)getLocationAndFadeShow {

    [self.fadeBlackView show];
    [self.upDatingView show];
    [self.mapLoacation start];
}

- (void)getCityIdAndFadeShow {
    
    [self.fadeBlackView show];
    [self.upDatingView show];
}

#pragma mark - MapManagerDelegate

- (void)mapManager:(MapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(delayRunEvent:) withObject:location afterDelay:0.3f];
}

- (void)mapManager:(MapManager *)manager didFailed:(NSError *)error {
    
    NSLog(@"定位失败");
    [self.upDatingView showFailed];
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Failed to locate" description:@"Sorry, temporarily unable to locate your position." type:TWMessageBarMessageTypeError callback:^{}];
        
    } afterDelaySecs:1.f];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.fadeBlackView hide];
        [self.upDatingView hide];
        [self.failedView show];
        
    } afterDelaySecs:2.5f];
}

- (void)mapManagerServerClosed:(MapManager *)manager {
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Failed to locate" description:@"Please turn on your Location Service." type:TWMessageBarMessageTypeError callback:^{}];
    }];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.fadeBlackView hide];
        [self.upDatingView hide];
        [self.failedView show];
        
    } afterDelaySecs:1.5];
}

#pragma mark -

- (void)delayRunEvent:(id)object {
    
    self.getWeatherData.location = object;
    // [self.getWeatherData startGetLocationWeatherData];
    [self.getWeatherData startGetLocalRandomData];
}

- (void)weatherData:(id)object sucess:(BOOL)sucess {
    
    if (sucess) {
        
        CurrentWeatherData *data       = [object valueForKey:@"WeatherData"];
        CurrentConditions  *conditions = [object valueForKey:@"WeatherConditions"];
        
        self.weatherView.weahterData       = data;
        self.weatherView.weatherConditions = conditions;
        
        [self.weatherView hide];
        
        [GCDQueue executeInMainQueue:^{
            
            [self.weatherView show];
            [self.fadeBlackView hide];
            [self.upDatingView hide];
            [self.failedView remove];
            
        } afterDelaySecs:1.f];
        
    } else {
        
        [self.upDatingView showFailed];
        [GCDQueue executeInMainQueue:^{
            
            [self.fadeBlackView hide];
            [self.upDatingView hide];
            [self.failedView show];
            
        } afterDelaySecs:2.51f];
        
        [self showErrorInfo];
    }
}

- (void)showErrorInfo {
    
    [GCDQueue executeInMainQueue:^{
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Network Unreachable" description:@"Please try later." type:TWMessageBarMessageTypeError callback:^{}];
        
    } afterDelaySecs:1.f];
}

- (void)pressEvent:(FailedLongPressView *)view {
    
    [self.failedView hide];
    [self getLocationAndFadeShow];
}

#pragma mark - 定制转场动画

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [PresentingAnimator new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [DismissingAnimator new];
}

@end
