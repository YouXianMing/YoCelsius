//
//  Networking.h
//  Networking
//
//  Created by YouXianMing on 15/8/1.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RequestDictionarySerialization.h"
#import "ResponseDataSerialization.h"

@class Networking;

#pragma mark - 协议
@protocol NetworkingDelegate <NSObject>

- (void)requestSucess:(Networking *)networking data:(id)data;
- (void)requestFailed:(Networking *)networking error:(NSError *)error;

@end

@interface Networking : NSObject


@property (nonatomic, strong, readonly)  AFHTTPRequestOperationManager  *manager;
@property (nonatomic, strong, readwrite) AFHTTPRequestOperation         *httpOperation;
@property (nonatomic, strong, readwrite) id <AFURLRequestSerialization>  requestSerializer;
@property (nonatomic, strong, readwrite) id <AFURLResponseSerialization> responseSerializer;


@property (nonatomic, weak)   id <NetworkingDelegate> delegate;


@property (nonatomic)         NSInteger      tag;
@property (nonatomic, strong) NSNumber      *timeoutInterval;
@property (nonatomic, strong) NSString      *urlString;
@property (nonatomic, strong) NSDictionary  *requestDictionary;
@property (nonatomic, strong) NSDictionary  *HTTPHeaderFieldsWithValues;


@property (nonatomic, strong) id <RequestDictionarySerialization>  requestDictionarySerializer;
@property (nonatomic, strong) id <ResponseDataSerialization>       responseDataSerializer;


- (void)startRequest;
- (void)cancelRequest;


/**
 *  显示网络指示状态(请手动在程序启动的时候调用)
 *
 *  @param show 是否显示网络指示状态
 */
+ (void)showNetworkActivityIndicator:(BOOL)show;


/**
 *  基本请求
 *
 *  @param urlString          请求地址
 *  @param requestDictionary  请求参数字典
 *  @param delegate           代理
 *  @param timeoutInterval    超时时间,可以不设置
 *  @param tag                标签值
 *  @param requestSerializer  AFHTTPRequestSerializer AFJSONRequestSerializer AFPropertyListRequestSerializer
 *  @param responseSerializer AFHTTPResponseSerializer AFJSONResponseSerializer AFXMLParserResponseSerializer AFXMLDocumentResponseSerializer AFPropertyListResponseSerializer AFImageResponseSerializer AFCompoundResponseSerializer
 *
 *  @return 请求实例对象
 */
+ (id)networkingWithUrlString:(NSString *)urlString
            requestDictionary:(NSDictionary *)requestDictionary
                     delegate:(id <NetworkingDelegate>)delegate
              timeoutInterval:(NSNumber *)timeoutInterval
                          tag:(NSInteger)tag
         requestSerialization:(id <AFURLRequestSerialization>)requestSerializer
        responseSerialization:(id <AFURLResponseSerialization>)responseSerializer;


@end
