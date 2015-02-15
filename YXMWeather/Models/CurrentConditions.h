//
//  CurrentConditions.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "WeatherInfo.h"

/*
 GET请求
 @"http://api.openweathermap.org/data/2.5/forecast/daily"
   
 参数列表
 @{@"lat"  : @"39.88293652833437",
 @"lon"  : @"116.4621119300779"}
 */

@interface CurrentConditions : NSObject


@property (nonatomic, strong) City           *city;     // 城市信息
@property (nonatomic, strong) NSArray        *list;     // WeatherInfo信息列表


@property (nonatomic, strong) NSNumber       *message;  // System parameter, do not use it
@property (nonatomic, strong) NSString       *cod;
@property (nonatomic, strong) NSNumber       *cnt;      // Number of lines returned by this API call


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

