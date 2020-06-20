//
//  WeatherInfo.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Temp.h"
#import "Weather.h"

@interface WeatherInfo : NSObject

@property (nonatomic, strong) NSArray        *weather;   // Weather信息列表
@property (nonatomic, strong) Temp           *temp;      // Temperature, Kelvin (subtract 273.15 to convert to Celsius)

@property (nonatomic, strong) NSNumber       *clouds;    // Cloudiness, %
@property (nonatomic, strong) NSNumber       *humidity;  // Humidity, %
@property (nonatomic, strong) NSNumber       *dt;        // Data receiving time, unix time, GMT
@property (nonatomic, strong) NSNumber       *speed;     // Wind speed, mps
@property (nonatomic, strong) NSNumber       *pressure;  // Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
@property (nonatomic, strong) NSNumber       *deg;       // Wind direction, degrees (meteorological)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

