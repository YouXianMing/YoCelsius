//
//  TitleMoveLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/24.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "TitleMoveLabel.h"

@interface TitleMoveLabel ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation TitleMoveLabel

- (void)buildView {
    
    self.backgroundColor = [UIColor clearColor];
    
    // 添加label
    self.label                 = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textAlignment   = NSTextAlignmentLeft;
    self.label.backgroundColor = [UIColor clearColor];
    self.label.text            = self.text;
    [self addSubview:self.label];
    
    // 设置文本颜色
    if (self.textColor) {
        
        self.label.textColor = self.textColor;
    }
    
    // 设置字体
    if (self.font) {
        
        self.label.font = self.font;
    }
    
    // 重置frame值
    [self.label sizeToFit];
    
    // 重设当前view的frame值
    self.width = self.label.width;
    self.height = self.label.height;
    
    // 存储frame值
    self.label.x  -= self.moveGap;
    self.startRect = self.label.frame;
    
    self.label.x  += self.moveGap;
    self.midRect   = self.label.frame;
    
    self.label.x  += self.moveGap;
    self.endRect   = self.label.frame;
    
    // 复位frame值
    self.label.frame = self.startRect;
    self.label.alpha = 0.f;
}

- (void)show {
    
    [UIView animateWithDuration:TITLE_MOVE_LABEL_SHOW_DURATION animations:^{
        
        self.label.frame = self.midRect;
        self.label.alpha = 1.f;
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:TITLE_MOVE_LABEL_HIDE_DURATION animations:^{
        
        self.label.frame = self.endRect;
        self.label.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.label.frame = self.startRect;
    }];
}

+ (TitleMoveLabel *)withText:(NSString *)text {
    
    TitleMoveLabel *titleMove = [[TitleMoveLabel alloc] initWithFrame:CGRectMake(20, 10, 0, 0)];
    titleMove.text            = text;
    titleMove.textColor       = [UIColor blackColor];
    
    if (iPhone4_4s || iPhone5_5s) {
        
        titleMove.font    = [UIFont fontWithName:LATO_BOLD size:LATO_14];
        
    } else if (iPhone6_6s) {
        
        titleMove.font    = [UIFont fontWithName:LATO_LIGHT size:17];
        
    } else if (iPhone6_6sPlus) {
        
        titleMove.font    = [UIFont fontWithName:LATO_LIGHT size:20];
        
    } else {
        
        titleMove.font    = [UIFont fontWithName:LATO_BOLD size:LATO_14];
    }
    
    titleMove.moveGap = 10.f;
    [titleMove buildView];
    
    return titleMove;
}

@end
