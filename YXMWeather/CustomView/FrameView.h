//
//  FrameView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/16.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+StringHeight.h"

@interface FrameView : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) UIColor  *textColor;

@property (nonatomic)         CGFloat   underLineWidth;
@property (nonatomic, strong) UIColor  *underLineColor;

- (void)buildViews;

- (void)fadeToShow;
- (void)fadeTohide;

@end
