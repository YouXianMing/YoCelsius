//
//  PathDirectionView.h
//  Path
//
//  Created by XianMingYou on 15/2/27.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"

@interface PathDirectionView : UIView

/**
 *  起始点在右边
 */
@property (nonatomic) BOOL  startPointAtRight;

/**
 *  根据百分比显示
 *
 *  @param percent 百分比
 */
- (void)showPercent:(CGFloat)percent;

@end
