//
//  LabelView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/16.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LabelView.h"

@interface LabelView ()

@property (nonatomic) CGFloat          labelWidth;
@property (nonatomic) CGFloat          labelHeight;

@property (nonatomic, strong) UILabel *label;

@end

@implementation LabelView

- (void)buildView {
    
    // 设置label
    self.label.text      = self.text;
    self.label.font      = self.font;
    self.label.textColor = self.textColor;
    
    // 获取宽度
    self.labelWidth   = [self.text widthWithLabelFont:self.font];
    self.labelHeight  = [self.text heightWithLabelFont:self.font withLabelWidth:MAXFLOAT];
    self.label.width  = self.labelWidth;
    self.label.height = self.labelHeight;

    // 计算间距
    self.label.x = self.gapFromLeft;
    self.label.y = self.gapFromTop;
    
    // 重新设置尺寸
    self.width  = self.labelWidth + self.gapFromLeft + self.gapFromRight;
    self.height = self.labelHeight + self.gapFromTop + self.gapFromBottom;
    
    // 设置背景色
    if (self.color) {
        
        self.backgroundColor = self.color;
    }
}

@synthesize label = _label;

- (UILabel *)label {
    
    if (_label == nil) {
        
        _label               = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return _label;
}

+ (instancetype)createWithText:(NSString *)text atOrigin:(CGPoint)origin {
    
    LabelView *labelView    = [[LabelView alloc] initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
    labelView.color         = [UIColor blackColor];
    labelView.text          = text;
    labelView.textColor     = [UIColor whiteColor];
    labelView.font          = [UIFont fontWithName:LATO_BOLD size:8];
    labelView.gapFromLeft   = 10.f;
    labelView.gapFromRight  = 10.f;
    labelView.gapFromTop    = 2.f;
    labelView.gapFromBottom = 2.f;
    
    [labelView buildView];

    return labelView;
}

@end
