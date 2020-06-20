//
//  AlphaView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>


@interface AlphaView : UIView

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic)         CGPoint  startPoint;
@property (nonatomic)         CGPoint  endPoint;

- (void)alphaType;

@end
