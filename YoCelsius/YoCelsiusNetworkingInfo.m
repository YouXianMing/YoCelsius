//
//  YoCelsiusNetworkingInfo.m
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/13.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "YoCelsiusNetworkingInfo.h"

@implementation YoCelsiusNetworkingInfo

- (void)showMessage {
    
    NSString *method = nil;
    switch (self.networking.method) {
            
        case kNetworkingGET:
            method = @"GET";
            break;
            
        case kNetworkingPOST:
            method = @"POST";
            break;
            
        case kNetworkingUPLOAD:
            method = @"UPLOAD";
            break;
            
        default:
            break;
    }
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"\n\n-------------------------------------------------------------------------\n"];
    
    if (self.networking.serviceInfo) {
        
        [string appendFormat:@"服务描述: %@\n\n", self.networking.serviceInfo];
    }
    
    [string appendFormat:@"服务地址: [%@] %@\n\n", method, self.networking.urlString];
    
    if (self.networking.responseSerializer.acceptableContentTypes.allObjects.count) {
        
        [string appendFormat:@"Response ContentTypes: %@\n\n", self.networking.responseSerializer.acceptableContentTypes];
    }
    
    if (self.networking.HTTPHeaderFieldsWithValues.allKeys.count) {
        
        [string appendFormat:@"头部信息: \n%@\n", self.networking.HTTPHeaderFieldsWithValues];
    }
    
    if (self.networking.requestParameter) {
        
        [string appendFormat:@"参数列表: \n%@\n", self.networking.requestParameter];
    }
    
    [string appendString:@"-------------------------------------------------------------------------\n"];
    
    NSLog(@"%@", string);
}

@end
