//
//  Networking+YoCelsius.m
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/8.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "Networking+YoCelsius.h"
#import "YoCelsiusRequestParameterSerializer.h"
#import "YoCelsiusNetworkingInfo.h"

@implementation NetworkConfig

@end

@implementation Networking (YoCelsius)

+ (instancetype)networkingWithNetworkConfig:(NetworkConfig *)config requestParameter:(id)requestParameter delegate:(id <NetworkingDelegate>)delegate {
    
    Networking *networking = [Networking networkingWithUrlString:config.urlString
                                                requestParameter:requestParameter
                                                          method:config.method
                                      requestParameterSerializer:[YoCelsiusRequestParameterSerializer new]
                                          responseDataSerializer:nil
                                       constructingBodyWithBlock:nil
                                                        progress:nil
                                                             tag:config.tag
                                                        delegate:delegate
                                               requestSerializer:[AFHTTPRequestSerializer serializer]
                                              responseSerializer:[AFJSONResponseSerializer serializer]];
    networking.timeoutInterval = @(8.f);
    networking.serviceInfo     = config.functionName;
    networking.networkingInfo  = [YoCelsiusNetworkingInfo new];
    
    return networking;
}

@end
