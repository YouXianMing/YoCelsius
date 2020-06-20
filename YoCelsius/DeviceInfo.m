//
//  DeviceInfo.m
//  YoCelsius
//
//  Created by YouXianMing on 2020/6/20.
//  Copyright © 2020 XianMingYou. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

+ (BOOL)isFringeScreen {
    
    static BOOL isFringeScreen = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (@available(iOS 11.0, *)) {
            
            isFringeScreen = [[[UIApplication sharedApplication] windows] firstObject].safeAreaInsets.bottom > 0;
        }
    });
    
    return isFringeScreen;
}

+ (CGFloat)fringeScreenTopSafeHeight {
    
    static CGFloat height = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (DeviceInfo.isFringeScreen) {
            
            height = 44.f;
        }
    });
    
    return height;
}

+ (CGFloat)fringeScreenBottomSafeHeight {
    
    static CGFloat height = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (DeviceInfo.isFringeScreen) {
            
            height = 34.f;
        }
    });
    
    return height;
}

@end
