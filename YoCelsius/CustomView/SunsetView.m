//
//  SunsetView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SunsetView.h"

@interface SunsetViewStoreValue : NSObject

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation SunsetViewStoreValue

@end

@interface SunsetView ()

@property (nonatomic, strong) UIView                *upView;
@property (nonatomic, strong) UIView                *downView;
@property (nonatomic, strong) UIImageView           *sunImageView;
@property (nonatomic, strong) SunsetViewStoreValue  *sunImageViewStoreValue;
@property (nonatomic, strong) UIImageView           *moonImageView;
@property (nonatomic, strong) SunsetViewStoreValue  *moonImageViewStoreValue;
@property (nonatomic, strong) UIView                *lineView;

@end

@implementation SunsetView

/**
 *  创建出view
 */
- (void)buildView {
    
    self.upView                     = [[UIView alloc] initWithFrame:self.upCenterRect];
    self.upView.layer.masksToBounds = YES;
    [self addSubview:self.upView];
    
    self.downView                     = [[UIView alloc] initWithFrame:self.downCenterRect];
    self.downView.layer.masksToBounds = YES;
    [self addSubview:self.downView];
    
    // 创建出太阳的view并存储一些相关参数
    self.sunImageView           = [[UIImageView alloc] initWithFrame:self.upView.frame];
    self.sunImageView.image     = [UIImage imageNamed:@"sun"];
    [self.upView addSubview:self.sunImageView];
    self.sunImageView.alpha     = 0.f;
    self.sunImageViewStoreValue = [SunsetViewStoreValue new];
    self.sunImageViewStoreValue.startRect = self.sunImageView.frame;
    self.sunImageView.y                  += self.sunImageView.height;
    self.sunImageViewStoreValue.midRect   = self.sunImageView.frame;
    self.sunImageView.y                  += 10.f;
    self.sunImageViewStoreValue.endRect   = self.sunImageView.frame;
    self.sunImageView.frame = self.sunImageViewStoreValue.startRect;
    
    // 创建出月亮的view并存储一些相关参数
    self.moonImageView           = [[UIImageView alloc] initWithFrame:self.upView.bounds];
    self.moonImageView.image     = [UIImage imageNamed:@"moon"];
    self.moonImageView.y        -= self.moonImageView.height;
    [self.downView addSubview:self.moonImageView];
    self.moonImageViewStoreValue = [SunsetViewStoreValue new];
    self.moonImageViewStoreValue.startRect = self.moonImageView.frame;
    self.moonImageView.y                  += self.moonImageView.height;
    self.moonImageViewStoreValue.midRect   = self.moonImageView.frame;
    self.moonImageView.y                  += 10.f;
    self.moonImageViewStoreValue.endRect   = self.moonImageView.frame;
    self.moonImageView.frame = self.moonImageViewStoreValue.startRect;
    self.moonImageView.alpha = 0.f;
    
    // 中间的线条
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height / 2.f, self.width, 1)];
    self.lineView.backgroundColor = COLOR_CIRCLE_;
    [self addSubview:self.lineView];
    self.lineView.alpha = 0.f;
}

/**
 *  显示动画
 *
 *  @param duration 动画时间
 */
- (void)showWithDuration:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunImageView.frame = self.sunImageViewStoreValue.midRect;
        self.sunImageView.alpha = 1.f;
        
        self.moonImageView.frame = self.moonImageViewStoreValue.midRect;
        self.moonImageView.alpha = 1.f;
        
        self.lineView.alpha = 1.f;
    }];
}

/**
 *  隐藏动画
 *
 *  @param duration 动画时间
 */
- (void)hideWithDuration:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunImageView.frame = self.sunImageViewStoreValue.endRect;
        self.sunImageView.alpha = 0.f;
        
        self.moonImageView.frame          = self.moonImageViewStoreValue.endRect;
        self.moonImageView.alpha          = 0.f;
        self.downView.layer.masksToBounds = NO;
        
        self.lineView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.sunImageView.frame  = self.sunImageViewStoreValue.startRect;
        self.moonImageView.frame = self.moonImageViewStoreValue.startRect;
        self.downView.layer.masksToBounds = YES;
    }];
}

@end
