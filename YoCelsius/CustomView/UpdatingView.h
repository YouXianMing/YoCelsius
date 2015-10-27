//
//  UpdatingView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/28.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "SnowView.h"
#import "UIView+GlowView.h"
#import "UIView+SetRect.h"
#import "CALayer+MaskLayer.h"

@interface UpdatingView : UIView

- (void)insertIntoView:(UIView *)view;

- (void)show;
- (void)hide;
- (void)showFailed;

@end
