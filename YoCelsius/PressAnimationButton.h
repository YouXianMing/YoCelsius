//
//  PressAnimationButton.h
//  Button
//
//  Created by XianMingYou on 15/1/30.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
@class PressAnimationButton;

@protocol PressAnimationButtonDelegate <NSObject>

- (void)finishedEventWith:(PressAnimationButton *)button;

@end

@interface PressAnimationButton : UIView

@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIColor  *normalTextColor;
@property (nonatomic, strong) UIColor  *highlightTextColor;

@property (nonatomic, strong) UIColor  *animationColor;
@property (nonatomic)         CGFloat   animationWidth; // 动画的宽度

@property (nonatomic, weak)   id<PressAnimationButtonDelegate>  delegate; // 代理

/**
 *  动画结束 + 恢复正常的时间
 */
@property (nonatomic) CGFloat toEndDuration;
@property (nonatomic) CGFloat toNormalDuration;

@end
