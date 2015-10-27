//
//  Temp.m
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import "Temp.h"

@implementation Temp

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if([key isEqualToString:@"id"]) {
//        self.productID = value;
//    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
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