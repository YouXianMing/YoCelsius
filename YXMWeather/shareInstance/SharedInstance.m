//
//  SharedInstance.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "SharedInstance.h"

static GlobalValue *_globalValue = nil;

@implementation SharedInstance

+ (void)initialize {
    if (self == [SharedInstance class]) {
        _globalValue = [GlobalValue new];
    }
}

+ (GlobalValue *)globalValue {
    return _globalValue;
}

@end
