//
//  Clouds.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clouds : NSObject

@property (nonatomic, strong) NSNumber *all; // Cloudiness, %

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

