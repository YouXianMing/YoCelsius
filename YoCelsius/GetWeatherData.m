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
#import "Networking.h"

static NSString *appIdKey = @"8c0e04b52e6da9e67c51a102d6269a60";

typedef enum : NSUInteger {
    
    kWeather = 0x11,
    kDaily,
    
} EGetWeatherDataValue;

@interface GetWeatherData () <AbsNetworkingDelegate>

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
    
    NSString *baseUrl   = @"http://api.openweathermap.org/data/2.5/weather";
    NSString *latStr    = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    NSString *lonStr    = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    NSString *urlString = [NSString stringWithFormat:@"%@?lat=%@&lon=%@&APPID=%@", baseUrl, latStr, lonStr, appIdKey];
    
    // 请求1
    self.networkWeather                  = [Networking new];
    self.networkWeather.urlString        = urlString;
    self.networkWeather.tag              = kWeather;
    self.networkWeather.delegate         = self;
    self.networkWeather.timeoutInterval  = @(8.f);
    self.networkWeather.method           = [PostMethod type];
    self.networkWeather.requestBodyType  = [HttpBodyType type];
    self.networkWeather.responseDataType = [JsonDataType type];
    [self.networkWeather startRequest];
    
    //  请求2
    self.networkDaily                  = [Networking new];
    self.networkDaily.tag              = kDaily;
    self.networkDaily.delegate         = self;
    self.networkDaily.timeoutInterval  = @(8.f);
    self.networkDaily.method           = [PostMethod type];
    self.networkDaily.requestBodyType  = [HttpBodyType type];
    self.networkDaily.responseDataType = [JsonDataType type];
}

- (void)requestSucess:(Networking *)networking data:(id)data {
    
    if (networking.tag == kWeather) {
        
        // 请求1结果
        CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.currentWeatherData = currentData;
            
            NSString *baseUrl   = @"http://api.openweathermap.org/data/2.5/forecast/daily";
            NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&cnt=%@&APPID=%@", baseUrl, self.currentWeatherData.cityId, @"14", appIdKey];
            
            self.networkDaily.urlString = urlString;
            
            [self.networkDaily startRequest];
            
        } else {
            
            [_delegate weatherData:nil sucess:NO];
        }
        
    } else if (networking.tag == kDaily) {
        
        // 请求2结果
        CurrentConditions *currentData = [[CurrentConditions alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.currentConditions = currentData;
            [_delegate weatherData:@{@"WeatherData"       : self.currentWeatherData,
                                     @"WeatherConditions" : self.currentConditions}
                            sucess:YES];
        } else {
            
            [_delegate weatherData:nil sucess:NO];
        }
    }
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {
    
    [_delegate weatherData:nil sucess:NO];
}

@end
