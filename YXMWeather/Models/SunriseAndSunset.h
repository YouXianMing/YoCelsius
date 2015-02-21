//
//  SunriseAndSunset.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunriseAndSunset : NSObject

@property (nonatomic)                   NSTimeInterval  utcSec;      // 获取到的UTC时间
@property (nonatomic, strong, readonly) NSString       *timeString;  // 时间字符串

/**
 *  开始处理时间信息
 */
- (void)accessUtcSec;

@end
