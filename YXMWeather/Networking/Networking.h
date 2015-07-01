//
//  Networking.h
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//
//  https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
//  https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
//
//  = HTTP请求格式 =
//  ------------------------------
//  * 请求方法 (GET、POST等)       *
//  * 请求头   (HttpHeaderFields) *
//  * 请求正文 (数据)              *
//  ------------------------------
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class Networking;


/**
 *  用于测试网络是否可以连接的基准URL地址
 */
static NSString *reachabeBaseURL               = @"http://baidu.com/";

/**
 *  提供给外部监听用,监测网络状态变化
 */
static NSString *NetworkingReachability        = @"_networkingReachability_";

/**
 *  外部接收通知用字符串
 */
static NSString *NetworkingStatus_WWAN         = @"_netStatus_WWAN_";
static NSString *NetworkingStatus_WIFI         = @"_netStatus_WIFI_";
static NSString *NetworkingStatus_NotReachable = @"_netStatus_NotReachable_";


typedef void(^ConstructingBodyBlock)(id<AFMultipartFormData> formData);


typedef enum : NSUInteger {
    
    GET_METHOD,                  // GET请求
    POST_METHOD,                 // POST请求
    UPLOAD_DATA,                 // 上传文件的请求(POST请求)
    
} AFNetworkingRequestMethod;


typedef enum : NSUInteger {
    
    /*------ 常用 ------*/
    HTTPRequestType = 0x11,      // 二进制格式 (不设置的话为默认格式)
    JSONRequestType,             // JSON方式
    /*-----------------*/
    
    PlistRequestType,            // 集合文件方式
    
} AFNetworkingRequestType;


typedef enum : NSUInteger {
    
    /*------ 常用 ------*/
    HTTPResponseType = 0x33,     // 二进制格式 (不设置的话为默认格式)
    JSONResponseType,            // JSON方式
    XMLType,                     // XML的方式
    ImageResponseType,           // 图片方式
    /*-----------------*/
    
    PlistResponseType,           // 集合文件方式
    CompoundResponseType,        // 组合方式
    
} AFNetworkingResponseType;


@protocol NetworkingDelegate <NSObject>
@optional
/**
 *  请求成功
 *
 *  @param networking Networking实例对象
 *  @param data       数据
 */
- (void)requestSucess:(Networking *)networking data:(id)data;

/**
 *  请求失败
 *
 *  @param networking Networking实例对象
 *  @param error      错误信息
 */
- (void)requestFailed:(Networking *)networking error:(NSError *)error;

/**
 *  用户取消请求
 *
 *  @param networking Networking实例对象
 *  @param error      错误信息
 */
- (void)userCanceledFailed:(Networking *)networking error:(NSError *)error;

@end

@interface Networking : NSObject

/**
 *  是否显示网络提示(左上角旋转的Indicator,默认为显示)
 *
 *  @param show
 */
+ (void)showNetworkActivityIndicator:(BOOL)show;

/**
 *  开始网络监测(默认就是开启)
 */
+ (void)startMonitoring;

/**
 *  停止网络监测
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

/**
 *  代理
 */
@property (nonatomic, weak)  id <NetworkingDelegate>  delegate;

/**
 *  标识符
 */
@property (nonatomic, strong) NSString               *flag;

/**
 *  超时时间间隔(设置了才能生效,不设置,使用的是AFNetworking自身的超时时间间隔)
 */
@property (nonatomic, strong) NSNumber               *timeoutInterval;

/**
 *  请求的类型
 */
@property (nonatomic) AFNetworkingRequestType         requestType;

/**
 *  回复的类型
 */
@property (nonatomic) AFNetworkingResponseType        responseType;

/**
 *  请求的方法类型
 */
@property (nonatomic) AFNetworkingRequestMethod       RequestMethod;

/**
 *  网络请求地址
 */
@property (nonatomic, strong) NSString               *urlString;

/**
 *  作为请求数据字典
 */
@property (nonatomic, strong) NSDictionary           *requestDictionary;

/**
 *  设置请求头部信息用字典(字典均由字符串组成,字典的key为HTTPHeaderField,value为其对应的值)
 */
@property (nonatomic, strong) NSDictionary           *HTTPHeaderFieldsWithValues;

/**
 *  构造数据用block(用于UPLOAD_DATA方法)
 */
@property (nonatomic, copy)   ConstructingBodyBlock   constructingBodyBlock;

/**
 *
 *  -====== 此方法由继承的子类来重载实现 ======-
 *
 *  转换请求字典
 *
 *  @return 转换后的字典
 */
- (NSDictionary *)transformRequestDictionary;

/**
 *
 *  -====== 此方法由继承的子类来重载实现 ======-
 *
 *  对返回的结果进行转换
 *
 *  @return 转换后的结果
 */
- (id)transformRequestData:(id)data;

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancelRequest;

#pragma mark - 便利构造器方法

/**
 *  便利构造器方法
 *
 *  @param urlString         请求地址
 *  @param requestDictionary 请求参数
 *  @param delegate          代理
 *  @param timeoutInterval   超时时间
 *  @param flag              标签
 *  @param requestMethod     请求方法
 *  @param requestType       请求类型
 *  @param responseType      回复数据类型
 *
 *  @return 实例对象
 */
+ (instancetype)networkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                               delegate:(id)delegate
                        timeoutInterval:(NSNumber *)timeoutInterval
                                   flag:(NSString *)flag
                          requestMethod:(AFNetworkingRequestMethod)requestMethod
                            requestType:(AFNetworkingRequestType)requestType
                           responseType:(AFNetworkingResponseType)responseType;

#pragma mark - block的形式请求

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


/**
 *  上传文件(POST请求)
 *
 *  @param URLString    请求地址
 *  @param parameters   网址参数
 *  @param timeInterval 超时时间(可以设置为nil)
 *  @param requestType  请求类型
 *  @param responseType 返回结果类型
 *  @param block        构造上传数据
 *  @param success      成功时调用的block
 *  @param failure      失败时调用的block
 *
 *  @return 网络操作句柄
 */
+ (AFHTTPRequestOperation *)UploadDataWithUrlString:(NSString *)URLString
                                         parameters:(id)parameters
                                    timeoutInterval:(NSNumber *)timeInterval
                                        requestType:(AFNetworkingRequestType)requestType
                                       responseType:(AFNetworkingResponseType)responseType
                          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
