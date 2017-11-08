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
#import "Networking+YoCelsius.h"

@interface GetWeatherData () <NetworkingDelegate>

@property (nonatomic, strong) CurrentConditions  *currentConditions;
@property (nonatomic, strong) CurrentWeatherData *currentWeatherData;
@property (nonatomic, strong) Networking         *networkWeather;
@property (nonatomic, strong) Networking         *networkDaily;

@end

@implementation GetWeatherData

- (void)startGetLocationWeatherData {
    
    if (self.location == nil || self.networkWeather.isRunning || self.networkDaily.isRunning) {
        
        return;
    }
    
    self.networkWeather = [Networking networkingWithNetworkConfig:weather()
                                                 requestParameter:@{@"lat" : [NSString stringWithFormat:@"%f", self.location.coordinate.latitude],
                                                                    @"lon" : [NSString stringWithFormat:@"%f", self.location.coordinate.longitude]}
                                                         delegate:self];
    [self.networkWeather startRequest];
}

- (void)networkingRequestSucess:(Networking *)networking tag:(NSInteger)tag data:(id)data {
    
    if (tag == kWeather) {
        
        CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.currentWeatherData = currentData;
            self.networkDaily       = [Networking networkingWithNetworkConfig:forecastDaily()
                                                             requestParameter:@{@"id"  : self.currentWeatherData.cityId,
                                                                                @"cnt" : @"14"}
                                                                     delegate:self];
            [self.networkDaily startRequest];
            
        } else {
            
            [_delegate weatherData:nil sucess:NO];
        }
        
    } else if (tag == kForecastDaily) {
        
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

- (void)networkingRequestFailed:(Networking *)networking tag:(NSInteger)tag error:(NSError *)error {
    
    [_delegate weatherData:nil sucess:NO];
}

@end
