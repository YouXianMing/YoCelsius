//
//  GetNetworking.m
//  Networking
//
//  Created by YouXianMing on 15/8/1.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "GetNetworking.h"

@implementation GetNetworking

- (void)startRequest {
    
    [super startRequest];
    
    // 开始请求
    __weak Networking *weakSelf = self;
    self.httpOperation = [self.manager GET:self.urlString
                                parameters:[self.requestDictionarySerializer transformRequestDictionaryWithInputDictionary:self.requestDictionary]
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                           
                                           [weakSelf.delegate requestSucess:weakSelf
                                                                       data:[weakSelf.responseDataSerializer transformResponseDataWithInputData:responseObject]];
                                       }
                                   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                           
                                           [weakSelf.delegate requestFailed:weakSelf error:error];
                                       }
                                   }];
}

@end
