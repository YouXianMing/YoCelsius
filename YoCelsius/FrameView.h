//
//  FrameView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/16.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
