//
//  FailedLongPressView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/10.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "FailedLongPressView.h"


@interface FailedLongPressViewStoreValue : NSObject

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation FailedLongPressViewStoreValue

@end

@interface FailedLongPressView ()<PressAnimationButtonDelegate>

@property (nonatomic, strong) LineBackgroundView             *lineBackgroundView;

@property (nonatomic, strong) PressAnimationButton           *pressButton;
@property (nonatomic, strong) FailedLongPressViewStoreValue  *pressButtonStoreValue;

@property (nonatomic, strong) UIImageView                    *iconView;
@property (nonatomic, strong) FailedLongPressViewStoreValue  *iconViewStoreValue;

@end

@implementation FailedLongPressView

- (void)buildView {
    
    // 封面图标
    self.iconView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
    self.iconView.height = 180;
    self.iconView.width  = 180;
    self.iconView.center = self.center;
    self.iconView.y     -= 100;
    [self addSubview:self.iconView];
    
    self.iconViewStoreValue           = [FailedLongPressViewStoreValue new];
    self.iconViewStoreValue.midRect   = self.iconView.frame;
    self.iconView.y                  -= 20;
    self.iconViewStoreValue.startRect = self.iconView.frame;
    self.iconView.y                  += 40;
    self.iconViewStoreValue.endRect   = self.iconView.frame;
    self.iconView.frame               = self.iconViewStoreValue.startRect;
    self.iconView.alpha               = 0.f;

    // 背景view
    self.lineBackgroundView = [LineBackgroundView createViewWithFrame:self.bounds
                                                            LineWidth:4
                                                              lineGap:4
                                                            lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.035]];
    [self addSubview:self.lineBackgroundView];
    
    // 长按按钮
    self.pressButton = [[PressAnimationButton alloc] initWithFrame:CGRectMake(0, 0, Width - 30, 48)];
    [self addSubview:self.pressButton];
    self.pressButton.font               = [UIFont fontWithName:LATO_LIGHT size:20.f];
    self.pressButton.layer.borderColor  = [UIColor blackColor].CGColor;
    self.pressButton.normalTextColor    = [UIColor blackColor];
    self.pressButton.highlightTextColor = [UIColor whiteColor];
    self.pressButton.layer.borderWidth  = 0.5f;
    self.pressButton.animationColor     = [UIColor blackColor];
    self.pressButton.animationWidth     = Width - 110;
    self.pressButton.text               = @"Long Press To Update";
    self.pressButton.center             = self.center;
    self.pressButton.y                  = self.height - 60;
    self.pressButton.delegate           = self;
    
    self.pressButtonStoreValue           = [FailedLongPressViewStoreValue new];
    self.pressButtonStoreValue.midRect   = self.pressButton.frame;
    self.pressButton.y                  -= 20;
    self.pressButtonStoreValue.startRect = self.pressButton.frame;
    self.pressButton.y                  += 25;
    self.pressButtonStoreValue.endRect   = self.pressButton.frame;
    self.pressButton.frame               = self.pressButtonStoreValue.startRect;
    self.pressButton.alpha               = 0.f;
}

- (void)finishedEventWith:(PressAnimationButton *)button {
    
    NSLog(@"长按效果");
    if (_delegate && [_delegate respondsToSelector:@selector(pressEvent:)]) {
        
        [_delegate pressEvent:self];
    }
}

- (void)show {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.pressButton.frame = self.pressButtonStoreValue.midRect;
        self.pressButton.alpha = 1.f;
        
        self.iconView.frame    = self.iconViewStoreValue.midRect;
        self.iconView.alpha    = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.pressButton.frame = self.pressButtonStoreValue.endRect;
        self.pressButton.alpha = 0.f;
        
        self.iconView.frame    = self.iconViewStoreValue.endRect;
        self.iconView.alpha    = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.pressButton.frame = self.pressButtonStoreValue.startRect;
        self.iconView.frame    = self.iconViewStoreValue.startRect;
    }];
}

- (void)remove {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.lineBackgroundView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
