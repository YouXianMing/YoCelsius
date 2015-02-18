//
//  HumidityView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/18.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumidityView : UIView

/**
 *  百分比
 */
@property (nonatomic) CGFloat percent;

- (void)buildView;

- (void)show;
- (void)hide;

@end
