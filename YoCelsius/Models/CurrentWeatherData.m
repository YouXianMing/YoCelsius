//
//  CurrentWeatherData.m
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import "CurrentWeatherData.h"

@implementation CurrentWeatherData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if([key isEqualToString:@"id"]) {
        
        self.cityId = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([key isEqualToString:@"coord"]) {
        
        value = [[Coord alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"sys"]) {
        
        value = [[Sys alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"main"]) {
        
        value = [[MainInfo alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"wind"]) {
        
        value = [[Wind alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"clouds"]) {
        
        value = [[Clouds alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"weather"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp         = value;
        NSMutableArray *weatherList = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            Weather *weather = [[Weather alloc] initWithDictionary:data];
            [weatherList addObject:weather];
        }
        
        value = weatherList;
    }

    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        self = [super init];
        
        if (self) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
        
        return self;
        
    } else {
        
        return nil;
    }    
}

@end