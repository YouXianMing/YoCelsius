//
//  Networking.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@implementation Networking

+ (AFHTTPRequestOperationManager *)GET:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString
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
    
    return manager;
}

+ (AFHTTPRequestOperation *)GETMethod:(NSString *)URLString
                           parameters:(id)parameters
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
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


+ (AFHTTPRequestOperationManager *)POST:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer                         = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:URLString
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
    
    return manager;
}

+ (AFHTTPRequestOperation *)POSTMethod:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer                         = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
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


@end
