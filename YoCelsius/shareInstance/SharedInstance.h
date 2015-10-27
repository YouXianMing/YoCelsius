//
//  SharedInstance.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import "GlobalValue.h"

#define  STORE_VALUE  [SharedInstance globalValue]

@interface SharedInstance : NSObject

+ (GlobalValue *)globalValue;

@end
