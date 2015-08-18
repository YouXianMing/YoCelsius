//
//  NetworkingReachability.m
//  BaseViewControllers
//
//  Created by YouXianMing on 15/8/6.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NetworkingReachability.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

static AFHTTPRequestOperationManager *_managerReachability = nil;
static BOOL                           _canSendMessage      = YES;

@implementation NetworkingReachability

+ (void)initialize {
    
    if (self == [NetworkingReachability class]) {
        
        NSURL *baseURL       = [NSURL URLWithString:reachabeBaseURL];
        _managerReachability = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        
        NSOperationQueue *operationQueue = _managerReachability.operationQueue;
        [_managerReachability.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [operationQueue setSuspended:NO];
                    
                    if (_canSendMessage == YES) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_NETWORKING_REACHABILITY
                                                                            object:nil
                                                                          userInfo:@{MSG_NETWORKING_REACHABILITY: NetworkingStatus_WWAN}];
                    }
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    
                    if (_canSendMessage == YES) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_NETWORKING_REACHABILITY
                                                                            object:nil
                                                                          userInfo:@{MSG_NETWORKING_REACHABILITY: NetworkingStatus_WIFI}];
                    }
                    
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    
                    if (_canSendMessage == YES) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_NETWORKING_REACHABILITY
                                                                            object:nil
                                                                          userInfo:@{MSG_NETWORKING_REACHABILITY: NetworkingStatus_NotReachable}];
                    }
                    
                    break;
            }
        }];
    }
}

+ (void)startMonitoring {
    _canSendMessage = YES;
    [_managerReachability.reachabilityManager startMonitoring];
}

+ (void)stopMonitoring {
    _canSendMessage = NO;
    [_managerReachability.reachabilityManager stopMonitoring];
}

+ (BOOL)isReachable {
    return _managerReachability.reachabilityManager.isReachable;
}

+ (BOOL)isReachableViaWWAN {
    return _managerReachability.reachabilityManager.isReachableViaWWAN;
}

+ (BOOL)isReachableViaWiFi {
    return _managerReachability.reachabilityManager.isReachableViaWiFi;
}

@end
