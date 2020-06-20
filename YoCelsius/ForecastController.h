//
//  ForecastController.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/26.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "CurrentConditions.h"

@interface ForecastController : UIViewController

@property (nonatomic, strong) CurrentConditions *weatherCondition;

@end
