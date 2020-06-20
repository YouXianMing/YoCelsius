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

@property (nonatomic, strong) NSMutableDictionary *datas;

@end

@implementation GetWeatherData

- (void)startGetLocationWeatherData {
    
    if (self.location == nil || self.networkWeather.isRunning || self.networkDaily.isRunning) {
        
        return;
    }
    
    self.networkWeather = [Networking networkingWithNetworkConfig:weather()
                                                 requestParameter:@{@"lon" : [NSString stringWithFormat:@"%f", self.location.coordinate.longitude],
                                                                    @"lat" : [NSString stringWithFormat:@"%f", self.location.coordinate.latitude],}
                                                         delegate:self];
    [self.networkWeather startRequest];
    
    self.datas = [NSMutableDictionary dictionary];
}

- (void)networkingRequestSucess:(Networking *)networking tag:(NSInteger)tag data:(id)data {
    
    if (tag == kWeather) {
        
        CurrentWeatherData *currentData = [[CurrentWeatherData alloc] initWithDictionary:data];
        if (currentData.cod.integerValue == 200) {
            
            self.datas[@"CurrentWeatherData"] = data;
            
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
                        
            self.datas[@"CurrentConditions"] = data;
            
            // NSLog(@"\n\n%@\n\n", self.datas.toJSONString);
            
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
    
    NSArray *datasPaths = @[@"Maqiao.json".bundleFile,
                            @"Columbia.json".bundleFile,
                            @"Cupertino.json".bundleFile,
                            @"Haidian.json".bundleFile,
                            @"NewYork.json".bundleFile];
    
    NSData       *data = [[NSData alloc] initWithContentsOfFile:datasPaths[arc4random() % datasPaths.count]];
    NSDictionary *dic  = [data toListProperty];
    
    CurrentWeatherData *weatherData = [[CurrentWeatherData alloc] initWithDictionary:dic[@"CurrentWeatherData"]];
    CurrentConditions  *conditions  = [[CurrentConditions alloc] initWithDictionary:dic[@"CurrentConditions"]];
    
    [GCDQueue executeInMainQueue:^{
        
        [self.delegate weatherData:@{@"WeatherData" : weatherData, @"WeatherConditions" : conditions} sucess:YES];
        
    } afterDelaySecs:0.5f];
}

@end
