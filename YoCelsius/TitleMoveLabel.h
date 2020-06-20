//
//  TitleMoveLabel.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

#define TITLE_MOVE_LABEL_SHOW_DURATION  1.75
#define TITLE_MOVE_LABEL_HIDE_DURATION  0.75

@interface TitleMoveLabel : UIView

@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor  *textColor;

// 移动距离
@property (nonatomic)         CGFloat   moveGap;

// 创建出view
- (void)buildView;
- (void)show;
- (void)hide;

// 初始化
+ (TitleMoveLabel *)withText:(NSString *)text;

@end
