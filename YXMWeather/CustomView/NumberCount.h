//
//  NumberCount.h
//  YXMWeather
//
//  Created by XianMingYou on 15/2/18.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NumberCount;

@protocol NumberCountDelegate <NSObject>

@optional
/**
 *  最原始的方法
 *
 *  @param numberCount 对象自己
 *  @param number      变化的值
 */
- (void)numberCount:(NumberCount *)numberCount currentNumber:(NSNumber *)number;

/**
 *  子类可以实现的方法
 *
 *  @param numberCount 对象自己
 *  @param string      子类返回的富文本
 */
- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string;

@end

@interface NumberCount : NSObject

/**
 *  代理
 */
@property (nonatomic, weak) id<NumberCountDelegate> delegate;

/**
 *  动画实体
 */
@property (nonatomic, strong) POPBasicAnimation *conutAnimation;

/**
 *  初始值
 */
@property (nonatomic) CGFloat fromValue;

/**
 *  结束值
 */
@property (nonatomic) CGFloat toValue;

/**
 *  动画持续时间
 */
@property (nonatomic) CGFloat duration;

/**
 *  开始动画
 */
- (void)startAnimation;

@end
