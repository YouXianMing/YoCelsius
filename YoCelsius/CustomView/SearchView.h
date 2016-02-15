//
//  SearchView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/3/2.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
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
