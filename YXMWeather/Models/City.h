//
//  City.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coord.h"

@interface City : NSObject

@property (nonatomic, strong) Coord          *coord;      // 经纬度

@property (nonatomic, strong) NSNumber       *cityId;     // 城市ID
@property (nonatomic, strong) NSString       *country;    // 国家
@property (nonatomic, strong) NSString       *name;       // 城市名字

@property (nonatomic, strong) NSNumber       *population;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

