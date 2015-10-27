//
//  GetWeatherData.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/25.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "GetWeatherData.h"
#import "CurrentConditions.h"
#import "CurrentWeatherData.h"
#import "GetNetworking.h"

static NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";

typedef enum : NSUInteger {
    
    WEATHER = 0x11,
    DAILY,
    
} EFlag;

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
    self.networkWeather = [GetNetworking networkingWithUrlString:@"http://api.openweathermap.org/data/2.5/weather"
                                               requestDictionary:@{@"lat"   : latStr,
                                                                   @"lon"   : lonStr,
                                                                   @"APPID" : appIdKey}
                                                        delegate:self
                                                 timeoutInterval:nil
                                                             tag:WEATHER
                                            requestSerialization:nil
                                           responseSerialization:[AFJSONResponseSerializer serializer]];
    [self.networkWeather startRequest];
    
    //  请求2
    self.networkDaily = [GetNetworking networkingWithUrlString:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                                             requestDictionary:nil
                                                      delegate:self
                                               timeoutInterval:nil
                                                           tag:DAILY
                                          requestSerialization:nil
                                         responseSerialization:[AFJSONResponseSerializer serializer]];
}


- (void)requestSucess:(Networking *)networking data:(id)data {

    if (networking.tag == WEATHER) {
        // 请求1结果
        
        CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.currentWeatherData = currentData;
            
            self.networkDaily.requestDictionary = @{@"id"    : self.currentWeatherData.cityId,
                                                    @"cnt"   : @"14",
                                                    @"APPID" : appIdKey};
            [self.networkDaily startRequest];
            
        } else {

            [_delegate weatherData:nil
                            sucess:NO];
        }
        
        
    } else if (networking.tag == DAILY) {
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
