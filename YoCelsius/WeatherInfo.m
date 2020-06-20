//
//  WeatherInfo.m
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import "WeatherInfo.h"

@implementation WeatherInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([key isEqualToString:@"temp"]) {
        
        value = [[Temp alloc] initWithDictionary:value];
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