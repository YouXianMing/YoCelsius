//
//  HumidityView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface HumidityView : UIView

/**
 *  百分比
 */
@property (nonatomic) CGFloat percent;

- (void)buildView;
- (void)show;
- (void)hide;

@end
