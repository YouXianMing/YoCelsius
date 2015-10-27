//
//  MainInfo.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainInfo : NSObject


@property (nonatomic, strong) NSNumber       *humidity;   // Humidity, %
@property (nonatomic, strong) NSNumber       *temp_min;   // Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
@property (nonatomic, strong) NSNumber       *temp_max;   // Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
@property (nonatomic, strong) NSNumber       *temp;       // Temperature, Kelvin (subtract 273.15 to convert to Celsius)
@property (nonatomic, strong) NSNumber       *pressure;   // Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
@property (nonatomic, strong) NSNumber       *sea_level;  // Atmospheric pressure on the sea level, hPa
@property (nonatomic, strong) NSNumber       *grnd_level; // Atmospheric pressure on the ground level, hPa


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

