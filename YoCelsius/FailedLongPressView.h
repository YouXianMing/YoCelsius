//
//  FailedLongPressView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/3/10.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "LineBackgroundView.h"
#import "PressAnimationButton.h"

@class FailedLongPressView;

@protocol FailedLongPressViewDelegate <NSObject>

- (void)pressEvent:(FailedLongPressView *)view;

@end

@interface FailedLongPressView : UIView

@property (nonatomic, weak) id<FailedLongPressViewDelegate> delegate;

- (void)buildView;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

/**
 *  移除
 */
- (void)remove;

@end
