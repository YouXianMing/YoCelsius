//
//  UpdatingView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/28.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "UpdatingView.h"

#define UPDATING_HEIGHY  20.f

@interface UpdatingViewStoreValue : NSObject

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation UpdatingViewStoreValue

@end

@interface UpdatingView ()
@property (nonatomic, strong) UILabel                 *label;           // 标题
@property (nonatomic, strong) UpdatingViewStoreValue  *labelStoreValue; // 标题存储值

@property (nonatomic, strong) UILabel                 *failedLabel;           // 失败
@property (nonatomic, strong) UpdatingViewStoreValue  *failedLabelStoreValue; // 失败存储值

@property (nonatomic, strong) SnowView                *snow;            // 下雪
@property (nonatomic, strong) UpdatingViewStoreValue  *snowStoreValue;  // 下雪存储值
@end

@implementation UpdatingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, Width / 2.f, Width / 2.f + UPDATING_HEIGHY)];
    if (self) {
        
        [self initLabel];
        [self initSnow];
        
        // 关闭用户交互
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)initLabel {
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, Width / 2.f, Width / 2.f, UPDATING_HEIGHY)];
    [self addSubview:self.label];
    self.label.textColor        = [UIColor whiteColor];
    self.label.textAlignment    = NSTextAlignmentCenter;
    self.label.font             = [UIFont fontWithName:LATO_LIGHT size:18.f];
    self.label.text             = @"Updating . . .";
    self.label.GCDTimerInterval = @(0.8f);
    self.label.glowDuration     = @(0.7f);
    self.label.glowLayerOpacity = @(1.f);
    [self.label createGlowLayerWithColor:[UIColor whiteColor]
                              glowRadius:2.f];
    [self.label startGlow];
    
    self.labelStoreValue           = [UpdatingViewStoreValue new];
    self.labelStoreValue.midRect   = self.label.frame;
    self.label.x                  -= 30.f;
    self.labelStoreValue.startRect = self.label.frame;
    self.label.x                  += 60.f;
    self.labelStoreValue.endRect   = self.label.frame;
    self.label.frame               = self.labelStoreValue.startRect;
    self.label.alpha               = 0.f;
    
    self.failedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Width / 2.f, Width / 2.f, UPDATING_HEIGHY)];
    [self addSubview:self.failedLabel];
    self.failedLabel.textColor        = [UIColor whiteColor];
    self.failedLabel.textAlignment    = NSTextAlignmentCenter;
    self.failedLabel.font             = [UIFont fontWithName:LATO_LIGHT size:24.f];
    self.failedLabel.text             = @"Failed";
    self.failedLabel.GCDTimerInterval = @(0.8f);
    self.failedLabel.glowDuration     = @(0.7f);
    self.failedLabel.glowLayerOpacity = @(1.f);
    [self.failedLabel createGlowLayerWithColor:[UIColor redColor]
                              glowRadius:2.f];
    [self.failedLabel startGlow];
    
    self.failedLabelStoreValue           = [UpdatingViewStoreValue new];
    self.failedLabelStoreValue.midRect   = self.failedLabel.frame;
    self.failedLabel.x                  -= 30.f;
    self.failedLabelStoreValue.startRect = self.failedLabel.frame;
    self.failedLabel.x                  += 60.f;
    self.failedLabelStoreValue.endRect   = self.failedLabel.frame;
    self.failedLabel.frame               = self.failedLabelStoreValue.startRect;
    self.failedLabel.alpha               = 0.f;
}

- (void)initSnow {
    
    self.snow = [[SnowView alloc] initWithFrame:CGRectMake(0, 0, Width / 2.f, Width / 2.f)];
    [self addSubview:self.snow];
    self.snow.snowImage  = [UIImage imageNamed:@"snow"];
    self.snow.birthRate  = 20.f;
    self.snow.gravity    = 5.f;
    self.snow.snowColor  = [UIColor whiteColor];
    self.snow.layer.mask = [CALayer createMaskLayerWithSize:CGSizeMake(Width / 2.f, Width / 2.f)
                                               maskPNGImage:[UIImage imageNamed:@"alpha"]];
    [self.snow showSnow];
    self.snow.transform  = CGAffineTransformMake(1.4, 0, 0, 1.4, 0, 0);
    self.snow.alpha      = 0.f;
}

- (void)show {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.snow.alpha      = 1.f;
        self.snow.transform  = CGAffineTransformMake(1.f, 0, 0, 1.f, 0, 0);
        
        self.label.frame     = self.labelStoreValue.midRect;
        self.label.alpha     = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.snow.alpha     = 0.f;
        self.snow.transform = CGAffineTransformMake(0.7f, 0, 0, 0.7f, 0, 0);
        
        self.label.frame    = self.labelStoreValue.endRect;
        self.label.alpha    = 0.f;
        
        self.failedLabel.frame = self.failedLabelStoreValue.endRect;
        self.failedLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.label.frame       = self.labelStoreValue.startRect;
        self.snow.transform    = CGAffineTransformMake(1.4, 0, 0, 1.4f, 0, 0);
        self.failedLabel.frame = self.self.failedLabelStoreValue.startRect;
    }];
}

- (void)insertIntoView:(UIView *)view {
    
}

- (void)showFailed {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        // 隐藏label标签
        self.label.frame = self.labelStoreValue.endRect;
        self.label.alpha = 0.f;
        
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1.f animations:^{
            // 显示failed标签
            self.failedLabel.frame = self.failedLabelStoreValue.midRect;
            self.failedLabel.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

@end
