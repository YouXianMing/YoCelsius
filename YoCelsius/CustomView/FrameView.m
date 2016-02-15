//
//  FrameView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/16.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "FrameView.h"
@class StoreFrameInfo;

typedef enum : NSUInteger {
    
    VIEW_START_FRAME,
    VIEW_MID_FRAME,
    VIEW_END_FRAME,
    
} EnumFrameView;

/* ------------------------------------------ */

@interface StoreFrameInfo : NSObject

@property (nonatomic, strong) NSMutableArray *frameArray; // 存储frame值
@property (nonatomic, strong) NSMutableArray *alphaArray; // 存储alpha值

- (CGRect)frameFrom:(EnumFrameView)type;
- (CGFloat)alphaFrom:(EnumFrameView)type;

@end

@implementation StoreFrameInfo

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.frameArray = [NSMutableArray array];
        self.alphaArray = [NSMutableArray array];
    }
    
    return self;
}

- (CGRect)frameFrom:(EnumFrameView)type {
    
    return [self.frameArray[type] CGRectValue];
}

- (CGFloat)alphaFrom:(EnumFrameView)type {
    
    return [self.alphaArray[type] floatValue];
}

@end

/* ------------------------------------------ */

@interface FrameView ()

@property (nonatomic, strong) UILabel        *textLabel;           // 显示的文本
@property (nonatomic, strong) StoreFrameInfo *textLabelFrame;      // 存储textLabel的frame值

@property (nonatomic, strong) UIView         *underlineView;       // 下划线
@property (nonatomic, strong) StoreFrameInfo *underlineViewFrame;  // 下划线以及其存储的值

@end

@implementation FrameView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 初始化数组
        self.textLabelFrame     = [StoreFrameInfo new];
        self.underlineViewFrame = [StoreFrameInfo new];
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.textLabel];
    
    self.underlineView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.underlineView];
}

- (void)buildViews {
    
    // 初始化标签
    [self initLabel];
    
    // 初始化下划线
    [self initUnderLine];
}

- (void)initUnderLine {
    
    CGFloat  lineWidth                 = self.underLineWidth;
    UIColor *lineColor                 = self.underLineColor;
    self.underlineView.height          = 1.f;
    self.underlineView.width           = lineWidth;
    self.underlineView.backgroundColor = lineColor;
    self.underlineView.y               = self.textLabel.height + 1;
    
    // 存储必要的信息
    self.underlineView.x    = lineWidth / 8.f;  // 起始位置
    NSValue *valueStart = [NSValue valueWithCGRect:self.underlineView.frame];
    self.underlineView.x    = 0;      // 中间位置
    NSValue *valueMid   = [NSValue valueWithCGRect:self.underlineView.frame];
    self.underlineView.x    = -lineWidth / 6.f; // 结束位置
    NSValue *valueEnd   = [NSValue valueWithCGRect:self.underlineView.frame];
    [self.underlineViewFrame.alphaArray addObject:@(0.0)];
    [self.underlineViewFrame.alphaArray addObject:@(1.0)];
    [self.underlineViewFrame.alphaArray addObject:@(0.0)];
    [self.underlineViewFrame.frameArray addObject:valueStart];
    [self.underlineViewFrame.frameArray addObject:valueMid];
    [self.underlineViewFrame.frameArray addObject:valueEnd];
    
    // 设置初始值
    self.underlineView.alpha = [self.underlineViewFrame alphaFrom:VIEW_START_FRAME];
    self.underlineView.frame = [self.underlineViewFrame frameFrom:VIEW_START_FRAME];
}

- (void)initLabel {
    
    // 获取属性值
    NSString *text      = self.text;
    UIColor  *textColor = self.textColor;
    UIFont   *font      = self.font;
    CGFloat   width     = [text widthWithLabelFont:self.font];
    CGFloat   height    = [text heightWithLabelFont:font withLabelWidth:MAXFLOAT];
    
    // 初始化label的属性
    self.textLabel.text      = text;
    self.textLabel.textColor = textColor;
    self.textLabel.font      = font;
    self.textLabel.width     = width;
    self.textLabel.height    = height;
    
    // 存储必要的信息
    self.textLabel.x    = -width / 8.f;
    NSValue *valueStart = [NSValue valueWithCGRect:self.textLabel.frame];
    self.textLabel.x    = 0;
    NSValue *valueMid   = [NSValue valueWithCGRect:self.textLabel.frame];
    self.textLabel.x    = width / 8.f;
    NSValue *valueEnd   = [NSValue valueWithCGRect:self.textLabel.frame];
    [self.textLabelFrame.alphaArray addObject:@(0.0)];
    [self.textLabelFrame.alphaArray addObject:@(1.0)];
    [self.textLabelFrame.alphaArray addObject:@(0.0)];
    [self.textLabelFrame.frameArray addObject:valueStart];
    [self.textLabelFrame.frameArray addObject:valueMid];
    [self.textLabelFrame.frameArray addObject:valueEnd];
    
    // 设置初始值
    self.textLabel.alpha = [self.textLabelFrame alphaFrom:VIEW_START_FRAME];
    self.textLabel.frame = [self.textLabelFrame frameFrom:VIEW_START_FRAME];
}

- (void)fadeToShow {
    
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:2 initialSpringVelocity:1.f options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.textLabel.alpha = [self.textLabelFrame alphaFrom:VIEW_MID_FRAME];
        self.textLabel.frame = [self.textLabelFrame frameFrom:VIEW_MID_FRAME];
        
        self.underlineView.alpha = [self.underlineViewFrame alphaFrom:VIEW_MID_FRAME];
        self.underlineView.frame = [self.underlineViewFrame frameFrom:VIEW_MID_FRAME];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)fadeTohide {
    
    [UIView animateWithDuration:1.5 delay:0.f usingSpringWithDamping:2 initialSpringVelocity:1.f options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.textLabel.alpha = [self.textLabelFrame alphaFrom:VIEW_END_FRAME];
        self.textLabel.frame = [self.textLabelFrame frameFrom:VIEW_END_FRAME];
        
        self.underlineView.alpha = [self.underlineViewFrame alphaFrom:VIEW_END_FRAME];
        self.underlineView.frame = [self.underlineViewFrame frameFrom:VIEW_END_FRAME];

    } completion:^(BOOL finished) {
        
        self.textLabel.alpha = [self.textLabelFrame alphaFrom:VIEW_START_FRAME];
        self.textLabel.frame = [self.textLabelFrame frameFrom:VIEW_START_FRAME];
        
        self.underlineView.alpha = [self.underlineViewFrame alphaFrom:VIEW_START_FRAME];
        self.underlineView.frame = [self.underlineViewFrame frameFrom:VIEW_START_FRAME];
    }];
}

@end
