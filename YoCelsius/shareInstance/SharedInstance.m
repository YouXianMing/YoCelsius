//
//  SharedInstance.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
