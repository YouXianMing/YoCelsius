//
//  Sys.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sys : NSObject


@property (nonatomic, strong) NSNumber       *message;  // System parameter, do not use it
@property (nonatomic, strong) NSString       *country;  // Country (GB, JP etc.)
@property (nonatomic, strong) NSNumber       *sunset;   // Sunrise time, unix, UTC
@property (nonatomic, strong) NSNumber       *sunrise;  // Sunset time, unix, UTC


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

