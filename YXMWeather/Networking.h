//
//  Networking.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef enum : NSUInteger {
    
    HTTPRequestType,  // 二进制格式
    JSONRequestType,  // JSON方式
    PlistRequestType, // 集合文件模式
    
} AFNetworkingRequestType;


typedef enum : NSUInteger {
    
    HTTPResponseType,     // 二进制格式
    JSONResponseType,     // JSON方式
    PlistResponseType,    // 集合文件方式
    ImageResponseType,    // 图片方式
    CompoundResponseType, // 组合方式
    
} AFNetworkingResponseType;


@interface Networking : NSObject


/**
 *  AFNetworking的GET请求
 *
 *  @param URLString    请求网址
 *  @param parameters   网址参数
 *  @param timeInterval 超时时间(可以设置为nil)
 *  @param requestType  请求类型
 *  @param responseType 返回结果类型
 *  @param success      成功时调用的block
 *  @param failure      失败时调用的block
 *
 *  @return 网络操作句柄
 */
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSNumber *)timeInterval
                    requestType:(AFNetworkingRequestType)requestType
                   responseType:(AFNetworkingResponseType)responseType
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  AFNetworking的POST请求
 *
 *  @param URLString    请求网址
 *  @param parameters   网址参数
 *  @param timeInterval 超时时间(可以设置为nil)
 *  @param requestType  请求类型
 *  @param responseType 返回结果类型
 *  @param success      成功时调用的block
 *  @param failure      失败时调用的block
 *
 *  @return 网络操作句柄
 */
+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                 timeoutInterval:(NSNumber *)timeInterval
                     requestType:(AFNetworkingRequestType)requestType
                    responseType:(AFNetworkingResponseType)responseType
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
