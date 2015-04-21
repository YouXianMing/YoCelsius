//
//  ForecastController.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/26.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentConditions.h"

@interface ForecastController : UIViewController

/**
 *  天气预报
 */
@property (nonatomic, strong) CurrentConditions *weatherCondition;

@end
