//
//  MaxTempView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaxTempView : UIView

/**
 *  最高温度
 */
@property (nonatomic) CGFloat maxTemp;

/**
 *  最低温度
 */
@property (nonatomic) CGFloat minTemp;

/**
 *  创建出view
 */
- (void)buildView;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
