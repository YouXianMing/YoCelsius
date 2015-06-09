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

@property (nonatomic)         BOOL                getDataFailed; // 获取数据失败


@end


@implementation GetWeatherData

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)requestOne {
    
    if (self.location == nil) {
        NSLog(@"先定位");
        return;
    }
    
    NSString *latStr = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    NSString *lonStr = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    
    // 网络请求1
    AFHTTPRequestOperation *operation = \
    [Networking GET:@"http://api.openweathermap.org/data/2.5/weather"
         parameters:@{@"lat"  : latStr,
                      @"lon"  : lonStr}
    timeoutInterval:nil
        requestType:HTTPRequestType
       responseType:JSONResponseType
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:responseObject];
                if (currentData.cod.integerValue == 200) {
                    self.currentWeatherData = currentData;
                    
                    // 再执行请求2
                    [self requestTwo];
                } else {
                    NSLog(@"请求1结果异常");
                    [_delegate weatherData:nil
                                    sucess:NO];
                }
                
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"请求1超时");
                [_delegate weatherData:nil
                                sucess:NO];
            }];
    [self.requestArray addObject:operation];
}

- (void)requestTwo {
    AFHTTPRequestOperation *operation = \
    [Networking GET:@"http://api.openweathermap.org/data/2.5/forecast/daily"
         parameters:@{@"id"   : self.currentWeatherData.cityId,
                      @"cnt"  : @"14"}
    timeoutInterval:nil
        requestType:HTTPRequestType
       responseType:JSONResponseType
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                CurrentConditions *currentData = [[CurrentConditions alloc] initWithDictionary:responseObject];
                if (currentData.cod.integerValue == 200) {
                    self.currentConditions = currentData;
                    [_delegate weatherData:@{@"WeatherData"       : self.currentWeatherData,
                                             @"WeatherConditions" : self.currentConditions}
                                    sucess:YES];
                } else {
                    [_delegate weatherData:nil
                                    sucess:NO];
                }

            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"请求2超时");
                [_delegate weatherData:nil
                                sucess:NO];
            }];
    
    [self.requestArray addObject:operation];
}

- (void)startGetLocationWeatherData {
    [self requestOne];
    
    return;
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
