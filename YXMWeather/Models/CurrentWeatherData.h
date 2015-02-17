//
//  CurrentWeatherData.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coord.h"
#import "Sys.h"
#import "MainInfo.h"
#import "Wind.h"
#import "Clouds.h"
#import "Weather.h"

/*
 
 GET请求
 @"http://api.openweathermap.org/data/2.5/weather"
 
 @{@"lat"  : @"39.88293652833437",
 @"lon"  : @"116.4621119300779"}
 
 */

@interface CurrentWeatherData : NSObject

@property (nonatomic, strong) NSNumber       *cod;      // 状态码
@property (nonatomic, strong) NSNumber       *cityId;   // 城市ID
@property (nonatomic, strong) NSString       *name;     // 城市名字
@property (nonatomic, strong) NSString       *base;     // 检测的站点
@property (nonatomic, strong) Coord          *coord;    // 经纬度坐标

@property (nonatomic, strong) NSNumber       *dt;       // Data receiving time, unix time, GMT

@property (nonatomic, strong) NSArray        *weather;  // 天气信息列表
@property (nonatomic, strong) MainInfo       *main;     // Group of weather parameters (Rain, Snow, Extreme etc.)
@property (nonatomic, strong) Sys            *sys;
@property (nonatomic, strong) Wind           *wind;
@property (nonatomic, strong) Clouds         *clouds;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

