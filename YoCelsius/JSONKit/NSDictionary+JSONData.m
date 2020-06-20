//
//  NSDictionary+JSONData.m
//  AFNetworking
//
//  Created by YouXianMing on 15/5/20.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSDictionary+JSONData.h"

@implementation NSDictionary (JSONData)

- (NSString *)toJSONString {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)toJSONStringAndReplaceSlash {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    return [string stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

- (NSString *)toReadableJSONString {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)toReadableJSONStringAndReplaceSlash {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    return [string stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

- (NSData *)toJSONData {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    return data;
}

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
}

@end
