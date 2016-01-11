//
//  V_3_X_NetworkingReachability.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "V_3_X_NetworkingReachability.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

/**
 *  用于测试网络是否可以连接的基准URL地址
 */
static NSString *reachabeBaseURL = @"http://baidu.com/";

static BOOL     _canSendMessage  = YES;

@implementation V_3_X_NetworkingReachability

+ (void)initialize {
    
    if (self == [V_3_X_NetworkingReachability class]) {
    
        [AFNetworkReachabilityManager managerForAddress:(__bridge const void * _Nonnull)(reachabeBaseURL)];
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    if (_canSendMessage == YES) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachableViaWWANNotification
                                                                            object:nil
                                                                          userInfo:nil];
                    }
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    
                    if (_canSendMessage == YES) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachableViaWIFINotification
                                                                            object:nil
                                                                          userInfo:nil];
                    }
                    
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    
                    if (_canSendMessage == YES) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingNotReachableNotification
                                                                            object:nil
                                                                          userInfo:nil];
                    }
                    
                    break;
            }
        }];
    }
}

+ (void)startMonitoring {
    
    _canSendMessage = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)stopMonitoring {
    
    _canSendMessage = NO;
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (BOOL)isReachable {
    
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

+ (BOOL)isReachableViaWWAN {
    
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
}

+ (BOOL)isReachableViaWiFi {
    
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
}

@end
