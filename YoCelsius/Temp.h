//
//  Temp.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temp : NSObject

@property (nonatomic, strong) NSNumber       *min;  // Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
@property (nonatomic, strong) NSNumber       *max;  // Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)

@property (nonatomic, strong) NSNumber       *morn;  // 早晨
@property (nonatomic, strong) NSNumber       *day;   // 白天
@property (nonatomic, strong) NSNumber       *night; // 下午
@property (nonatomic, strong) NSNumber       *eve;   // 午夜

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

