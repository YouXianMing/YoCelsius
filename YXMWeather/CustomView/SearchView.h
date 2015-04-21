//
//  SearchView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/3/2.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchView;

@protocol SearchViewDelegate <NSObject>
- (void)currentLocationWithView:(SearchView *)view;
@end

@interface SearchView : UIView

/**
 *  代理方法
 */
@property (nonatomic, weak) id<SearchViewDelegate>  delegate;

/**
 *  创建出view
 */
- (void)buildView;

@end
