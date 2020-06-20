//
//  TapTitleView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/3/2.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
@class TapTitleView;

@protocol TapTitleViewDelegate <NSObject>

@optional

- (void)tapTitleView:(TapTitleView *)tapView;

@end

@interface TapTitleView : UIView

@property (nonatomic, weak)   id<TapTitleViewDelegate>   delegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *normalColor;
@property (nonatomic, strong) UIColor  *tapColor;
@property (nonatomic, strong) UIFont   *font;

@end
