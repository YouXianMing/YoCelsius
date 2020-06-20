//
//  Wind.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wind : NSObject

@property (nonatomic, strong) NSNumber       *speed; // Wind speed, mps
@property (nonatomic, strong) NSNumber       *deg;   // Wind direction, degrees (meteorological)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

