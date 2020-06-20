//
//  ChangeColorLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/22.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ChangeColorLabel.h"
#import "NSString+StringHeight.h"
#import "AlphaView.h"

@interface ChangeColorLabel ()

@property (nonatomic, strong) UILabel   *showLabel;
@property (nonatomic, strong) UILabel   *alphaLabel;
@property (nonatomic, strong) AlphaView *alphaView;

@end

@implementation ChangeColorLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initLabels];
    }
    
    return self;
}

- (void)initLabels {
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.showLabel];
    
    self.alphaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.alphaLabel];
    
    // 设定alphaView
    self.alphaView = [[AlphaView alloc] initWithFrame:CGRectZero];
    self.alphaView.colors     = @[[UIColor clearColor],
                                  [UIColor blackColor],
                                  [UIColor blackColor],
                                  [UIColor clearColor]];
    self.alphaView.locations  = @[@(0.f), @(0.05), @(0.95), @(1.f)];
    self.alphaView.startPoint = CGPointMake(0, 0);
    self.alphaView.endPoint   = CGPointMake(1, 0);
    self.alphaLabel.maskView = self.alphaView;
}

/**
 *  设定文本后将会重新更新控件
 */
- (void)updateLabelView {
    
    // 字体
    UIFont  *font      = (self.font == nil ? self.showLabel.font : self.font);
    
    // 设置文本 + 设置颜色 + 设置字体
    self.showLabel.text  = self.text;
    self.alphaLabel.text = self.text;
    self.showLabel.textColor  = self.textColor;
    self.alphaLabel.textColor = self.changedColor;
    self.showLabel.font  = font;
    self.alphaLabel.font = font;
    
    // 重置文本位置
    [self.showLabel sizeToFit];
    [self.alphaLabel sizeToFit];
    
    // 重新设置alphaView的frame值
    self.alphaView.width  = self.showLabel.width;
    self.alphaView.height = self.showLabel.height;
}

/**
 *  文本颜色百分比
 *
 *  @param percent 百分比
 */
- (void)colorPercent:(CGFloat)percent {
    
    if (percent <= 0) {
        
        self.alphaView.x = -self.showLabel.width;
        
    } else {
        
        self.alphaView.x = -self.showLabel.width + percent * self.showLabel.width;
    }
}

@end
