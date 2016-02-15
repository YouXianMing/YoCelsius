//
//  MaxTempView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "MaxTempView.h"
#import "GridView.h"
#import "MaxTempCountLabel.h"
#import "MinTempContLabel.h"
#import "TitleMoveLabel.h"
#import "CGRectStoreValue.h"

@interface MaxTempView ()

@property (nonatomic, strong) GridView  *gridView;

@property (nonatomic, strong) UIView            *centerLineView;
@property (nonatomic, strong) CGRectStoreValue  *centerLineViewStoreValue;

@property (nonatomic, strong) UIView            *minTempView;
@property (nonatomic, strong) CGRectStoreValue  *minTempViewStoreValue;

@property (nonatomic, strong) UIView            *maxTempView;
@property (nonatomic, strong) CGRectStoreValue  *maxTempViewStoreValue;

@property (nonatomic, strong) UIView            *maxCountView;
@property (nonatomic, strong) CGRectStoreValue  *maxCountViewStoreValue;

@property (nonatomic, strong) UIView            *minCountView;
@property (nonatomic, strong) CGRectStoreValue  *minCountViewStoreValue;

@property (nonatomic, strong) MaxTempCountLabel *maxTempCountLabel;
@property (nonatomic, strong) MinTempContLabel  *minTempCountLabel;

@property (nonatomic, strong) TitleMoveLabel    *titleMoveLabel;

@end

@implementation MaxTempView

- (void)buildView {
    
    CGFloat gridOffsetX = 12;
    CGFloat gridOffsetY = 13;
    
    // 创建出格子view
    self.gridView       = [[GridView alloc] initWithFrame:CGRectZero];
    self.gridView.alpha = 0.f;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        gridOffsetX = 30;
        gridOffsetY = 45;
        self.gridView.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridView.gridLength = 23;
        
    } else if (iPhone6_6s) {
        
        gridOffsetX = 30;
        gridOffsetY = 50;
        self.gridView.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridView.gridLength = 26;
        
    } else if (iPhone6_6sPlus) {
        
        gridOffsetX = 30;
        gridOffsetY = 53;
        self.gridView.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridView.gridLength = 30;
        
    } else {
        
        self.gridView.origin     = CGPointMake(gridOffsetX, gridOffsetY);
        self.gridView.gridLength = 23;
    }
    
    [self.gridView buildView];
    [self addSubview:self.gridView];
    
    // 中间的横条view
    self.centerLineViewStoreValue = [CGRectStoreValue new];
    self.centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _gridView.gridLength * 2, _gridView.gridLength * 5, 1.f)];
    self.centerLineView.backgroundColor = [UIColor blackColor];
    
    self.centerLineView.x += gridOffsetX;
    self.centerLineView.y += gridOffsetY;
    self.centerLineViewStoreValue.midRect = self.centerLineView.frame;
    self.centerLineView.width = 0.f;
    self.centerLineViewStoreValue.startRect = self.centerLineView.frame;
    self.centerLineView.x = _gridView.gridLength * 5;
    self.centerLineViewStoreValue.endRect = self.centerLineView.frame;
    self.centerLineView.alpha = 0.f;
    self.centerLineView.frame = self.centerLineViewStoreValue.startRect;
    
    // 最小温度
    self.minTempViewStoreValue = [CGRectStoreValue new];
    self.minTempView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 1, _gridView.gridLength * 2, _gridView.gridLength * 1, 0)];
    self.minTempView.x += gridOffsetX;
    self.minTempView.y += gridOffsetY;
    self.minTempView.backgroundColor = [UIColor blackColor];
    self.minTempView.alpha = 0.f;
    self.minTempViewStoreValue.startRect = self.minTempView.frame;
    [self addSubview:self.minTempView];
    
    // 最低温度显示
    self.minCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 1, _gridView.gridLength * 2, _gridView.gridLength * 1, _gridView.gridLength)];
    [self addSubview:self.minCountView];
    self.minCountView.x += gridOffsetX;
    self.minCountView.y += gridOffsetY;
    self.minCountViewStoreValue = [CGRectStoreValue new];
    self.minCountViewStoreValue.startRect = self.minCountView.frame;
    self.minCountView.alpha = 0.f;

    // 最大温度
    self.maxTempViewStoreValue = [CGRectStoreValue new];
    self.maxTempView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 3, _gridView.gridLength * 2, _gridView.gridLength * 1, 0)];
    self.maxTempView.x += gridOffsetX;
    self.maxTempView.y += gridOffsetY;
    self.maxTempView.backgroundColor = [UIColor blackColor];
    self.maxTempViewStoreValue.startRect = self.maxTempView.frame;
    self.maxTempView.alpha = 0.f;
    
    // 最大温度显示
    self.maxCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 3, _gridView.gridLength * 2, _gridView.gridLength * 1, _gridView.gridLength)];
    [self addSubview:self.minCountView];
    self.maxCountView.x += gridOffsetX;
    self.maxCountView.y += gridOffsetY;
    self.maxCountViewStoreValue = [CGRectStoreValue new];
    self.maxCountViewStoreValue.startRect = self.maxCountView.frame;
    [self addSubview:self.maxCountView];
    self.maxCountView.alpha = 0.f;
    
    // 最大温度动态显示
    self.maxTempCountLabel = [[MaxTempCountLabel alloc] initWithFrame:CGRectMake(0, 0, 60, _gridView.gridLength)];
    [self.maxCountView addSubview:self.maxTempCountLabel];

    // 最小温度动态显示
    self.minTempCountLabel = [[MinTempContLabel alloc] initWithFrame:CGRectMake(0, 0, 60, _gridView.gridLength)];
    [self.minCountView addSubview:self.minTempCountLabel];
    
    [self addSubview:self.maxTempView];
    [self addSubview:self.centerLineView];
    
    self.titleMoveLabel = [TitleMoveLabel withText:@"Min/Max Temp"];
    [self.titleMoveLabel buildView];
    [self addSubview:self.titleMoveLabel];
}

- (void)show {
    
    CGFloat duration = 1.75;
    
    // 标题显示
    [self.titleMoveLabel show];
    
    // 格子动画效果
    [self.gridView showWithDuration:1.5f];
    
    if (self.minTemp >= 0) {
        
        self.minCountView.y -= self.gridView.gridLength;
    }
    
    if (self.maxTemp >= 0) {
        
        self.maxCountView.y -= self.gridView.gridLength;
    }
    
    self.maxTempCountLabel.toValue = self.maxTemp;
    [self.maxTempCountLabel showDuration:duration];
    
    self.minTempCountLabel.toValue = self.minTemp;
    [self.minTempCountLabel showDuration:duration];
    
    // 中间线条动画效果
    [UIView animateWithDuration:0.75 delay:0.35 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        self.centerLineView.frame = self.centerLineViewStoreValue.midRect;
        self.centerLineView.alpha = 1.f;
        
        self.minTempView.height = self.minTemp;
        self.minTempView.y     -= self.minTemp;
        self.minTempView.alpha  = 1.f;
        self.minCountView.y    -= self.minTemp;
        self.minCountView.alpha = 1.f;

        self.maxTempView.height = self.maxTemp;
        self.maxTempView.y     -= self.maxTemp;
        self.maxTempView.alpha  = 1.f;
        self.maxCountView.y    -= self.maxTemp;
        self.maxCountView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    CGFloat duration = 0.75f;
    
    // 标题隐藏
    [self.titleMoveLabel hide];
    
    // 格子动画效果
    [self.gridView hideWithDuration:duration];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.centerLineView.alpha = 0.f;
        
        self.minTempView.frame = self.minTempViewStoreValue.startRect;
        self.minTempView.alpha = 0.f;
        
        self.maxTempView.frame = self.maxTempViewStoreValue.startRect;
        self.maxTempView.alpha = 0.f;
        
        self.minCountView.alpha   = 0.f;
        self.minCountView.x      += 10.f;
        self.maxCountView.alpha   = 0.f;
        self.maxCountView.x      += 10.f;

    } completion:^(BOOL finished) {
        
        self.centerLineView.frame = self.centerLineViewStoreValue.startRect;
        self.minCountView.frame   = self.minCountViewStoreValue.startRect;
        self.maxCountView.frame   = self.maxCountViewStoreValue.startRect;
    }];
}

@end
