//
//  LineAnimationView.h
//  AnimatedLineView
//
//  Created by XianMingYou on 15/3/4.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineAnimationView : UIView

@property (nonatomic) CGFloat maxAlpha;
@property (nonatomic) CGFloat fadeToShowDuration;
@property (nonatomic) CGFloat fadeToHideDuration;

@property (nonatomic) CGRect  startFrame;
@property (nonatomic) CGRect  midFrame;
@property (nonatomic) CGRect  endFrame;

- (void)show;
- (void)hide;

@end
