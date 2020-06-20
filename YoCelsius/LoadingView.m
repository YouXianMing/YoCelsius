//
//  LoadingView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "LoadingView.h"


@interface LoadingView ()
@property (nonatomic, strong) UIImageView  *staticImageView;
@property (nonatomic, strong) UIImageView  *animtedImageView;
@property (nonatomic, strong) NSNumber     *lock;
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.lock = @(NO);
        
        [self initViews];
        
        [self rotateImageViewWithCircleByOneSecond];
    }
    
    return self;
}

- (void)initViews {
    
    // 静态图片
    self.staticImageView       = [[UIImageView alloc] initWithFrame:self.bounds];
    self.staticImageView.alpha = 0.f;
    [self addSubview:self.staticImageView];
    
    // 动态图片
    self.animtedImageView       = [[UIImageView alloc] initWithFrame:self.bounds];
    self.animtedImageView.alpha = 0.f;
    [self addSubview:self.animtedImageView];
}

/**
 *  显示
 */
- (void)show {
    
    // 锁上
    if (self.lock.boolValue == NO) {
        
        self.lock = @(YES);
        
    } else {
        
        return;
    }
    
    CGFloat duration = 0.75f;
    
    self.staticImageView.transform  = CGAffineTransformMake(3.f, 0, 0, 3.f, 0, 0);
    self.animtedImageView.transform = CGAffineTransformMake(3.f, 0, 0, 3.f, 0, 0);
    
    [UIView animateWithDuration:duration delay:0.f
         usingSpringWithDamping:3.f
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            self.staticImageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                            self.staticImageView.alpha     = 1.f;
                            
                            self.animtedImageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                            self.animtedImageView.alpha     = 1.f;
                            
                        } completion:^(BOOL finished) {
                            
                        }];
}

/**
 *  隐藏
 */
- (void)hide {
    
    // 解锁
    self.lock = @(NO);
    
    CGFloat duration = 0.75f;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.staticImageView.transform = CGAffineTransformMake(1.2, 0, 0, 1.2, 0, 0);
        self.staticImageView.alpha     = 0.f;
        
        self.animtedImageView.transform = CGAffineTransformMake(1.2, 0, 0, 1.2, 0, 0);
        self.animtedImageView.alpha     = 0.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 重写setter,getter方法

@synthesize staticCircleImage = _staticCircleImage;

- (void)setStaticCircleImage:(UIImage *)staticCircleImage {
    
    _staticCircleImage         = staticCircleImage;
    self.staticImageView.image = staticCircleImage;
}

- (UIImage *)staticCircleImage {
    
    return _staticCircleImage;
}

@synthesize animtedImage = _animtedImage;

- (void)setAnimtedImage:(UIImage *)animtedImage {
    
    _animtedImage               = animtedImage;
    self.animtedImageView.image = animtedImage;
}

- (UIImage *)animtedImage {
    
    return _animtedImage;
}

- (void)rotateImageViewWithCircleByOneSecond {
    
    CGFloat circleByOneSecond = 3.f;
    
    // 执行动画
    [UIView animateWithDuration:1.f / circleByOneSecond
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
                         
                     } completion:^(BOOL finished){
                         
                         [self rotateImageViewWithCircleByOneSecond];
                     }];
}

@end
