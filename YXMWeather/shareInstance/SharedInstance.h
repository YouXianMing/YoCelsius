//
//  SharedInstance.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalValue.h"

#define  STORE_VALUE  [SharedInstance globalValue]

@interface SharedInstance : NSObject

+ (GlobalValue *)globalValue;

@end
