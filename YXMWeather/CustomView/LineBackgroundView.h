//
//  LineBackgroundView.h
//  LineBackgroundView
//
//  Created by XianMingYou on 15/3/4.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LineBackgroundView : UIView

@property (nonatomic) CGFloat            lineWidth;
@property (nonatomic) CGFloat            lineGap;
@property (nonatomic, strong) UIColor   *lineColor;

- (void)buildView;
+ (instancetype)createViewWithFrame:(CGRect)frame
                          LineWidth:(CGFloat)width
                            lineGap:(CGFloat)lineGap
                          lineColor:(UIColor *)color;

@end
