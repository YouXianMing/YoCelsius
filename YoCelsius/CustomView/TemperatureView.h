//
//  TemperatureView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface TemperatureView : UIView

/**
 *  温度
 */
@property (nonatomic) CGFloat temperature;

- (void)buildView;
- (void)show;
- (void)hide;

@end
