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

#import "NSDictionary+JSONData.h"
#import "NSArray+JSONData.h"
#import "NSData+JSONData.h"
#import "NSString+File.h"

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
                                                 requestParameter:@{@"lon" : [NSString stringWithFormat:@"%f", self.location.coordinate.longitude],
                                                                    @"lat" : [NSString stringWithFormat:@"%f", self.location.coordinate.latitude]}
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

- (void)startGetLocalRandomData {
    
    NSArray *datasPaths = @[@"Yicheng.json".bundleFile,
                            @"Arthur's Pass.json".bundleFile,
                            @"Haidian.json".bundleFile,
                            @"NewYork.json".bundleFile,
                            @"Amatepec.json".bundleFile,
                            @"Australia.json".bundleFile,
                            @"Fushan.json".bundleFile,
                            @"Gaoqiao.json".bundleFile,
                            @"Hinganghāt.json".bundleFile,
                            @"Kohlu.json".bundleFile,
                            @"Maqiao.json".bundleFile,
                            @"Northwest.json".bundleFile,
                            @"Osterley.json".bundleFile,
                            @"Shijiazhuang.json".bundleFile,
                            @"Wako.json".bundleFile,
                            @"Yerbogachën.json".bundleFile];
    
    static NSInteger index = 0;
    NSData       *data     = [[NSData alloc] initWithContentsOfFile:datasPaths[index % datasPaths.count]];
    NSDictionary *dic      = [data toListProperty];
    index                 += 1;
    
    CurrentWeatherData *weatherData = [[CurrentWeatherData alloc] initWithDictionary:dic[@"CurrentWeatherData"]];
    CurrentConditions  *conditions  = [[CurrentConditions alloc] initWithDictionary:dic[@"CurrentConditions"]];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.delegate weatherData:@{@"WeatherData" : weatherData, @"WeatherConditions" : conditions} sucess:YES];
        
    } afterDelaySecs:0.5f];
}

@end
