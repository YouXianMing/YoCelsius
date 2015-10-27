//
//  UploadNetworking.m
//  Networking
//
//  Created by YouXianMing on 15/8/2.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UploadNetworking.h"

@implementation UploadNetworking

- (void)startRequest {
    
    [super startRequest];
    
    NSParameterAssert(self.constructingBodyBlock);
    
    // 开始请求
    __weak UploadNetworking *weakSelf = self;
    self.httpOperation = [self.manager POST:self.urlString
                                 parameters:[self.requestDictionarySerializer transformRequestDictionaryWithInputDictionary:self.requestDictionary]
                  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                      
                      weakSelf.constructingBodyBlock(formData);
                  }
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
