//
//  NetworkingReachability.h
//  BaseViewControllers
//
//  Created by YouXianMing on 15/8/6.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通知中心监听字符串
 */
#define  MSG_NETWORKING_REACHABILITY  @"MSG_NETWORKING_REACHABILITY"

/**
 *  用于测试网络是否可以连接的基准URL地址
 */
static NSString *reachabeBaseURL               = @"http://baidu.com/";

/**
 *  外部接收通知用字符串
 */
static NSString *NetworkingStatus_WWAN         = @"_WWAN_";
static NSString *NetworkingStatus_WIFI         = @"_WIFI_";
static NSString *NetworkingStatus_NotReachable = @"_NONE_";

@interface NetworkingReachability : NSObject

/**
 *  开始监听网络状态
 */
+ (void)startMonitoring;

/**
 *  结束监听网络状态
 */
+ (void)stopMonitoring;

/**
 *  是否可以联网
 *
 *  @return YES为可以,NO为不行
 */
+ (BOOL)isReachable;

/**
 *  当前是否是WWAN网络
 *
 *  @return YES为是,NO为不是
 */
+ (BOOL)isReachableViaWWAN;

/**
 *  当前是否为WIFI网络
 *
 *  @return YES为是,NO为不是
 */
+ (BOOL)isReachableViaWiFi;

@end
