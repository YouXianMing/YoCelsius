//
//  UIView+SetRect.h
//  UIView
//
//  Created by YouXianMing on 16/1/29.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  Width             [UIScreen mainScreen].bounds.size.width
#define  Height            [UIScreen mainScreen].bounds.size.height
#define Screen_Size_Small  (Width == 320.f)
#define Screen_Size_Middle (Width == 375.f)
#define Screen_Size_Big    (Width == 414.f)

@interface UIView (SetRect)

/*----------------------
 * Absolute coordinate *
 ----------------------*/

@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

@end
