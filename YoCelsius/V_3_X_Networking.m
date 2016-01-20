//
//  V_3_X_Networking.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "V_3_X_Networking.h"
#import "AFNetworking.h"

@interface V_3_X_Networking ()

@property (nonatomic, strong) AFHTTPSessionManager *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation V_3_X_Networking

- (instancetype)init {
    
    if (self = [super init]) {
        
        // 基本设置
        self.method           = [GetMethod type];
        self.requestBodyType  = [HttpBodyType type];
        self.responseDataType = [HttpDataType type];
        self.timeoutInterval  = @(5);
        
        // AFNetworking 3.x 相关初始化
        self.session = [AFHTTPSessionManager manager];
        
        // 添加头部支持
        self.HTTPHeaderFieldsWithValues = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)startRequest {
    
    NSParameterAssert(self.urlString);
    
    [self resetData];
    
    [self accessRequestSerializer];
    
    [self accessResponseSerializer];
    
    [self accessHeaderField];
    
    [self accessTimeoutInterval];
    
    // 开始运行
    self.isRunning = YES;
    
    if ([self.method isKindOfClass:[GetMethod class]]) {
        
        __weak Networking *weakSelf = self;
        
        // GET请求
        NSDictionary *requstDictionary = [self accessRequestDictionarySerializerWithRequestDictionary:self.requestDictionary];
        
        self.dataTask = [self.session GET:self.urlString
                               parameters:requstDictionary
                                 progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      
                                      weakSelf.isRunning            = NO;
                                      weakSelf.originalResponseData = responseObject;
                                      
                                      // 如果设置了转换策略，则进行数据转换
                                      if (weakSelf.responseDataSerializer && [weakSelf.responseDataSerializer respondsToSelector:@selector(serializeResponseData:)]) {
                                          
                                          weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                      }
                                      
                                      if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                          
                                          [weakSelf.delegate requestSucess:weakSelf
                                                                      data:(weakSelf.serializerResponseData == nil ? weakSelf.originalResponseData : weakSelf.serializerResponseData)];
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      
                                      weakSelf.isRunning = NO;
                                      
                                      if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                          
                                          [weakSelf.delegate requestFailed:weakSelf error:error];
                                      }
                                  }];
        
    } else if ([self.method isKindOfClass:[PostMethod class]]) {
        
        // POST请求
        NSDictionary *requstDictionary = [self accessRequestDictionarySerializerWithRequestDictionary:self.requestDictionary];
        
        __weak Networking *weakSelf = self;
        self.dataTask = [self.session POST:self.urlString
                                parameters:requstDictionary
                                  progress:nil
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       
                                       weakSelf.isRunning            = NO;
                                       weakSelf.originalResponseData = responseObject;
                                       
                                       // 如果设置了转换策略，则进行数据转换
                                       if (weakSelf.responseDataSerializer && [weakSelf.responseDataSerializer respondsToSelector:@selector(serializeResponseData:)]) {
                                           
                                           weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                       }
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                           
                                           [weakSelf.delegate requestSucess:weakSelf
                                                                       data:(weakSelf.serializerResponseData == nil ? weakSelf.originalResponseData : weakSelf.serializerResponseData)];
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       
                                       weakSelf.isRunning = NO;
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                           
                                           [weakSelf.delegate requestFailed:weakSelf error:error];
                                       }
                                   }];
    }
}

- (void)cancelRequest {
    
    [self.dataTask cancel];
}

/**
 *  重置数据
 */
- (void)resetData {
    
    self.originalResponseData   = nil;
    self.serializerResponseData = nil;
}

/**
 *  处理请求body类型
 */
- (void)accessRequestSerializer {
    
    if ([self.requestBodyType isKindOfClass:[HttpBodyType class]]) {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[JsonBodyType class]]) {
        
        self.session.requestSerializer = [AFJSONRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[PlistBodyType class]]) {
        
        self.session.requestSerializer = [AFPropertyListRequestSerializer serializer];
        
    } else {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

/**
 *  处理回复data类型
 */
- (void)accessResponseSerializer {
    
    if ([self.responseDataType isKindOfClass:[HttpDataType class]]) {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if ([self.responseDataType isKindOfClass:[JsonDataType class]]) {
        
        self.session.responseSerializer = [AFJSONResponseSerializer serializer];
        
    } else {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
}

/**
 *  处理请求头部信息
 */
- (void)accessHeaderField {
    
    if (self.HTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.HTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.session.requestSerializer setValue:value forHTTPHeaderField:headerField];
        }
    }
}

/**
 *  设置超时时间
 */
- (void)accessTimeoutInterval {
    
    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        
        [self.session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.session.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

/**
 *  处理请求参数
 *
 *  @param requestDictionary 请求参数字典
 *
 *  @return 处理后的参数
 */
- (NSDictionary *)accessRequestDictionarySerializerWithRequestDictionary:(NSDictionary *)requestDictionary {
    
    if (self.requestDictionarySerializer &&
        [self.requestDictionarySerializer respondsToSelector:@selector(serializeRequestDictionary:)]) {
        
        return [self.requestDictionarySerializer serializeRequestDictionary:requestDictionary];
        
    } else {
        
        return requestDictionary;
    }
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking       = [[V_3_X_Networking alloc] init];
    networking.urlString         = urlString;
    networking.requestDictionary = requestDictionary;
    
    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking       = [[V_3_X_Networking alloc] init];
    networking.urlString         = urlString;
    networking.requestDictionary = requestDictionary;
    networking.method            = [PostMethod type];
    
    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

@end
