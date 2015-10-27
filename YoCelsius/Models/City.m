//
//  City.m
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import "City.h"

@implementation City

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]) {
        self.cityId = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ([key isEqualToString:@"coord"]) {
        value = [[Coord alloc] initWithDictionary:value];
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