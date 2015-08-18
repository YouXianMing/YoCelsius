//
//  Networking.m
//  Networking
//
//  Created by YouXianMing on 15/8/1.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "Networking.h"
#import "UIKit+AFNetworking.h"

@interface Networking ()

@property (nonatomic, strong) AFHTTPRequestOperationManager  *manager;

@end

@implementation Networking

#pragma mark - 初始化
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    self.manager = [AFHTTPRequestOperationManager manager];
}

- (void)cancelRequest {
    
    [self.httpOperation cancel];
}

- (void)startRequest {

    NSParameterAssert(self.urlString);
    
    // 请求类型
    if (self.requestSerializer) {
        
        self.manager.requestSerializer = self.requestSerializer;
        
    } else {
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    // 回复类型
    if (self.responseSerializer) {
        
        self.manager.responseSerializer = self.responseSerializer;
        
    } else {
        
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 设置请求头部信息
    if (self.HTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.HTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:headerField];
        }
    }
    
    // 设置超时时间
    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    // 设置输入参数转换
    if (self.requestDictionarySerializer == nil) {
        
        self.requestDictionarySerializer = [RequestDictionarySerializer new];
    }
    
    // 设置输出参数转换
    if (self.responseDataSerializer == nil) {
        
        self.responseDataSerializer = [ResponseDataSerializer new];
    }
    
    // 剩余的部分由子类完成
}

+ (void)showNetworkActivityIndicator:(BOOL)show {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:show];
}

+ (id)networkingWithUrlString:(NSString *)urlString
            requestDictionary:(NSDictionary *)requestDictionary
                     delegate:(id <NetworkingDelegate>)delegate
              timeoutInterval:(NSNumber *)timeoutInterval
                          tag:(NSInteger)tag
         requestSerialization:(id <AFURLRequestSerialization>)requestSerializer
        responseSerialization:(id <AFURLResponseSerialization>)responseSerializer {

    NSParameterAssert(urlString);
    
    Networking *networking       = [[[self class] alloc] init];
    networking.urlString         = urlString;
    networking.requestDictionary = requestDictionary;
    
    networking.delegate = delegate;
    
    networking.timeoutInterval = timeoutInterval;
    networking.tag             = tag;
    
    networking.requestSerializer  = requestSerializer;
    networking.responseSerializer = responseSerializer;
    
    return networking;
}

- (void)dealloc {

    [self.httpOperation cancel];
}

@end
