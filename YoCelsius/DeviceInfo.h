//
//  DeviceInfo.h
//  YoCelsius
//
//  Created by YouXianMing on 2020/6/20.
//  Copyright © 2020 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

+ (BOOL)isFringeScreen;

+ (CGFloat)fringeScreenTopSafeHeight;

+ (CGFloat)fringeScreenBottomSafeHeight;

@end
