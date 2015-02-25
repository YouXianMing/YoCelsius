//
//  GetWeatherData.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/25.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GetWeatherData.h"
#import "CurrentConditions.h"
#import "CurrentWeatherData.h"

@interface GetWeatherData ()
@property (nonatomic, strong) NSMutableArray     *requestArray;
@property (nonatomic, strong) CurrentConditions  *currentConditions;
@property (nonatomic, strong) CurrentWeatherData *currentWeatherData;
@end

@implementation GetWeatherData

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)startGetLocationWeatherData {
    
    if (self.location == nil) {
        NSLog(@"先定位");
        return;
    }
    
    NSString *latStr = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    NSString *lonStr = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    
    // 线程组
    GCDGroup *group = [GCDGroup new];
    
    // 网络请求1
    [[GCDQueue globalQueue] execute:^{
        GCDSemaphore *semaphore = [GCDSemaphore new];
        
        AFHTTPRequestOperation *operation = \
        [Networking GETMethod:@"http://api.openweathermap.org/data/2.5/weather"
                   parameters:@{@"lat"  : latStr,
                                @"lon"  : lonStr}
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:responseObject];
                          if (currentData.cod.integerValue == 200) {
                              self.currentWeatherData = currentData;
                          }
                          [semaphore signal];
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          [semaphore signal];
                      }];
        [self.requestArray addObject:operation];
        
        // 等待
        [semaphore wait];
    } inGroup:group];
    // 网络请求2
    [[GCDQueue globalQueue] execute:^{
        GCDSemaphore *semaphore = [GCDSemaphore new];
        
        AFHTTPRequestOperation *operation = \
        [Networking GETMethod:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                   parameters:@{@"lat"  : latStr,
                                @"lon"  : lonStr,
                                @"cnt"  : @"10"}
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          CurrentConditions *currentData = [[CurrentConditions alloc] initWithDictionary:responseObject];
                          if (currentData.cod.integerValue == 200) {
                              self.currentConditions = currentData;
                          }
                          [semaphore signal];
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          [semaphore signal];
                      }];
        [self.requestArray addObject:operation];

        // 等待
        [semaphore wait];
    } inGroup:group];
    [[GCDQueue mainQueue] notify:^{
        [self.requestArray removeAllObjects];
        if (_delegate && [_delegate respondsToSelector:@selector(weatherData:sucess:)]) {
            if (self.currentConditions && self.currentWeatherData) {
                [_delegate weatherData:@{@"WeatherData"       : self.currentWeatherData,
                                         @"WeatherConditions" : self.currentConditions}
                                sucess:YES];
            } else {
                [_delegate weatherData:nil
                                sucess:NO];
            }
        }
        
    } inGroup:group];

}

/**
 *  取消请求
 */
- (void)cancelRequest {
    for (int i = 0; i < self.requestArray.count; i++) {
        AFHTTPRequestOperation *operation = self.requestArray[i];
        [operation cancel];
    }
}

@end
