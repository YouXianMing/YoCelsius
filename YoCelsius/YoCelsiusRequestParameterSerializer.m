//
//  YoCelsiusRequestParameterSerializer.m
//  YoCelsius
//
//  Created by YouXianMing on 2017/11/8.
//  Copyright © 2017年 XianMingYou. All rights reserved.
//

#import "YoCelsiusRequestParameterSerializer.h"

static NSString *appIdKey = @"8c0e04b52e6da9e67c51a102d6269a60";

@implementation YoCelsiusRequestParameterSerializer

- (id)serializeRequestParameter:(id)requestParameter {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:requestParameter];
    params[@"APPID"]            = appIdKey;
    
    return params;
}

@end
