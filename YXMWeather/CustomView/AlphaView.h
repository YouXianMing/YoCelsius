//
//  AlphaView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlphaView : UIView

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic)         CGPoint  startPoint;
@property (nonatomic)         CGPoint  endPoint;

- (void)alphaType;

@end
