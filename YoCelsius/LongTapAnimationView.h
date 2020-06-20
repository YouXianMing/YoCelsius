//
//  LongTapAnimationView.h
//  YouXianMingClock
//
//  Created by YouXianMing on 14-10-13.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LongTapAnimationView;

@protocol LongTapAnimationViewDelegate <NSObject>

/**
 *  长按百分比
 *
 *  @param percent 百分比
 *  @param view    自身
 */
- (void)longPressPercentage:(CGFloat)percent view:(LongTapAnimationView *)view;
- (void)longPressCompleteWithView:(LongTapAnimationView *)view intNumber:(NSNumber *)number;

@end

@interface LongTapAnimationView : UIView

/**
 *  代理
 */
@property (nonatomic, assign) id<LongTapAnimationViewDelegate> delegate;

/**
 *  百分比
 */
@property (nonatomic, assign, readonly) CGFloat percent;

/**
 *  缩放比例
 */
@property (nonatomic, assign) CGFloat  scaleValue;

/**
 *  时候允许按下（默认为YES）
 */
@property (nonatomic, assign) BOOL     canTouch;

/**
 *  多长时间才能表示已经按下按钮激活事件
 */
@property (nonatomic, assign) NSTimeInterval completeDurationAfterLongPress;

/**
 *  倒计时时间（如果设置了倒计时时间，则completeDurationAfterLongPress会无效）
 */
@property (nonatomic, assign) NSInteger countDown;

/**
 *  激活按钮事件
 */
- (void)activateButtonEffect;

@end
