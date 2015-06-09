//
//  Networking.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "Networking.h"

@implementation Networking

+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSNumber *)timeInterval
                    requestType:(AFNetworkingRequestType)requestType
                   responseType:(AFNetworkingResponseType)responseType
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    
    
    // 设置请求类型
    manager.requestSerializer                         = [Networking requestSerializerWith:requestType];
    
    
    // 设置回复类型
    manager.responseSerializer                        = [Networking responseSerializerWith:responseType];
    
    
    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    // 设置超时时间
    if (timeInterval) {
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = timeInterval.floatValue;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    
    AFHTTPRequestOperation *httpOperation = [manager GET:URLString
                                              parameters:parameters
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     if (success) {
                                                         success(operation, responseObject);
                                                     }
                                                 }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     if (failure) {
                                                         failure(operation, error);
                                                     }
                                                 }];
    
    
    return httpOperation;
}


+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                 timeoutInterval:(NSNumber *)timeInterval
                     requestType:(AFNetworkingRequestType)requestType
                    responseType:(AFNetworkingResponseType)responseType
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    
    
    // 设置请求类型
    manager.requestSerializer                         = [Networking requestSerializerWith:requestType];
    
    
    // 设置回复类型
    manager.responseSerializer                        = [Networking responseSerializerWith:responseType];
    
    
    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    // 设置超时时间
    if (timeInterval) {
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = timeInterval.floatValue;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    
    AFHTTPRequestOperation *httpOperation = [manager POST:URLString
                                               parameters:parameters
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      if (success) {
                                                          success(operation, responseObject);
                                                      }
                                                  }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      if (failure) {
                                                          failure(operation, error);
                                                      }
                                                  }];
    
    
    return httpOperation;
}

#pragma mark - 私有方法

/**
 *  根据序列化枚举值返回对应的请求策略
 *
 *  @param serializerType 序列化枚举值
 *
 *  @return 序列化策略
 */
+ (AFHTTPRequestSerializer *)requestSerializerWith:(AFNetworkingRequestType)serializerType {
    if (serializerType == JSONRequestType) {
        return [AFJSONRequestSerializer serializer];
    } else if (serializerType == HTTPRequestType) {
        return [AFHTTPRequestSerializer serializer];
    } else if (serializerType == PlistRequestType) {
        return [AFPropertyListRequestSerializer serializer];
    } else {
        return nil;
    }
}

/**
 *  根据序列化枚举值返回对应的回复策略
 *
 *  @param serializerType 序列化枚举值
 *
 *  @return 序列化策略
 */
+ (AFHTTPResponseSerializer *)responseSerializerWith:(AFNetworkingResponseType)serializerType {
    if (serializerType == JSONResponseType) {
        return [AFJSONResponseSerializer serializer];
    } else if (serializerType == HTTPRequestType) {
        return [AFHTTPResponseSerializer serializer];
    } else if (serializerType == PlistRequestType) {
        return [AFPropertyListResponseSerializer serializer];
    } else if (serializerType == ImageResponseType) {
        return [AFImageResponseSerializer serializer];
    } else if (serializerType == CompoundResponseType) {
        return [AFCompoundResponseSerializer serializer];
    } else {
        return nil;
    }
}

@end
