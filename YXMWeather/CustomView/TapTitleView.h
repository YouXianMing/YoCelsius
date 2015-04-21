//
//  TapTitleView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/3/2.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TapTitleView;

@protocol TapTitleViewDelegate <NSObject>

@optional
- (void)tapTitleView:(TapTitleView *)tapView;

@end

@interface TapTitleView : UIView

@property (nonatomic, weak)   id<TapTitleViewDelegate>   delegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *normalColor;
@property (nonatomic, strong) UIColor  *tapColor;
@property (nonatomic, strong) UIFont   *font;

@end
