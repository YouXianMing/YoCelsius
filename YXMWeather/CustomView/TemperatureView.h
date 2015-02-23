//
//  TemperatureView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/22.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureView : UIView

/**
 *  温度
 */
@property (nonatomic) CGFloat temperature;

- (void)buildView;

- (void)show;
- (void)hide;


@end
