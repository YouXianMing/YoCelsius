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


#define  WEATHER  @"WEATHER"
#define  DAILY    @"DAILY"


@interface GetWeatherData () <NetworkingDelegate>


@property (nonatomic, strong) CurrentConditions  *currentConditions;
@property (nonatomic, strong) CurrentWeatherData *currentWeatherData;


@property (nonatomic, strong) Networking         *networkWeather;
@property (nonatomic, strong) Networking         *networkDaily;


@end


@implementation GetWeatherData


- (void)startGetLocationWeatherData {
    
    if (self.location == nil) {
        return;
    }
    
    NSString *latStr = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    NSString *lonStr = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    
    // 请求1
    self.networkWeather                   = [[Networking alloc] init];
    self.networkWeather.urlString         = @"http://api.openweathermap.org/data/2.5/weather";
    self.networkWeather.requestDictionary = @{@"lat"  : latStr,
                                              @"lon"  : lonStr};
    self.networkWeather.delegate          = self;
    self.networkWeather.flag              = WEATHER;
    self.networkWeather.RequestMethod     = GET_METHOD;
    self.networkWeather.requestType       = HTTPRequestType;
    self.networkWeather.responseType      = JSONResponseType;
    [self.networkWeather startRequest];
    
    //  请求2
    self.networkDaily                   = [[Networking alloc] init];
    self.networkDaily.urlString         = @"http://api.openweathermap.org/data/2.5/forecast/daily";
    self.networkDaily.delegate          = self;
    self.networkDaily.flag              = DAILY;
    self.networkDaily.RequestMethod     = GET_METHOD;
    self.networkDaily.requestType       = HTTPRequestType;
    self.networkDaily.responseType      = JSONResponseType;
}


- (void)requestSucess:(Networking *)networking data:(id)data {

    if ([networking.flag isEqualToString:WEATHER]) {
        // 请求1结果
        
        CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.currentWeatherData = currentData;
            
            self.networkDaily.requestDictionary = @{@"id"   : self.currentWeatherData.cityId,
                                                    @"cnt"  : @"14"};
            [self.networkDaily startRequest];
            
            
        } else {

            [_delegate weatherData:nil
                            sucess:NO];
        }
        
        
    } else if ([networking.flag isEqualToString:DAILY]) {
        // 请求2结果
        
        CurrentConditions *currentData = [[CurrentConditions alloc] initWithDictionary:data];
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
    
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {

    [_delegate weatherData:nil
                    sucess:NO];
}

- (void)userCanceledFailed:(Networking *)networking error:(NSError *)error {

    [_delegate weatherData:nil
                    sucess:NO];
}

@end
