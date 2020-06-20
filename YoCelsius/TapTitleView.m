//
//  TapTitleView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/2.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "TapTitleView.h"
#import "LongTapAnimationView.h"

@interface TapTitleView ()<LongTapAnimationViewDelegate>

@property (nonatomic, strong) UILabel              *normalLabel; // 普通的label
@property (nonatomic, strong) UILabel              *tapLabel;    // 变化的label
@property (nonatomic, strong) LongTapAnimationView *longTapView; // 长按其变化的view
@end

@implementation TapTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    // 普通label
    self.normalLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.normalLabel.textAlignment = NSTextAlignmentCenter;
    self.normalLabel.textColor     = [UIColor blackColor];

    // 变色的label
    self.tapLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.tapLabel.textAlignment = NSTextAlignmentCenter;
    self.tapLabel.textColor     = [UIColor redColor];
    self.tapLabel.alpha         = 0.f;

    // 点击变小的view
    self.longTapView            = [[LongTapAnimationView alloc] initWithFrame:self.bounds];
    self.longTapView.canTouch   = YES;
    self.longTapView.delegate   = self;
    self.longTapView.scaleValue = 0.95f;
    self.longTapView.completeDurationAfterLongPress = 0.05;
    [self.longTapView addSubview:self.normalLabel];
    [self.longTapView addSubview:self.tapLabel];
    [self addSubview:self.longTapView];
}

- (void)longPressPercentage:(CGFloat)percent view:(LongTapAnimationView *)view {
    
    self.tapLabel.alpha    = percent;
    self.normalLabel.alpha = 1 - percent;
}

- (void)longPressCompleteWithView:(LongTapAnimationView *)view intNumber:(NSNumber *)number {
    
    if (_delegate && [_delegate respondsToSelector:@selector(tapTitleView:)]) {
        
        [_delegate tapTitleView:self];
    }
}

@synthesize title = _title;

- (void)setTitle:(NSString *)title {
    
    _title                = title;
    self.normalLabel.text = title;
    self.tapLabel.text    = title;
}

- (NSString *)title {
    
    return _title;
}

@synthesize normalColor = _normalColor;

- (void)setNormalColor:(UIColor *)normalColor {
    
    _normalColor               = normalColor;
    self.normalLabel.textColor = normalColor;
}

- (UIColor *)normalColor {
    
    return _normalColor;
}

@synthesize tapColor = _tapColor;

- (void)setTapColor:(UIColor *)tapColor {
    
    _tapColor               = tapColor;
    self.tapLabel.textColor = tapColor;
}

- (UIColor *)tapColor {
    
    return _tapColor;
}

@synthesize font = _font;

- (void)setFont:(UIFont *)font {
    
    _font                 = font;
    self.normalLabel.font = font;
    self.tapLabel.font    = font;
}

- (UIFont *)font {
    
    return _font;
}

@end
