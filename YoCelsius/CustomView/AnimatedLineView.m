//
//  AnimatedLineView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "AnimatedLineView.h"

@interface AnimatedLineView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation AnimatedLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initRects];
        
        self.imageView       = [[UIImageView alloc] initWithFrame:self.startRect];
        self.imageView.alpha = 0.f;
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)initRects {
    
    CGRect rect    = self.bounds;
    self.startRect = CGRectMake(0, -10, rect.size.width, rect.size.height / 2.f);
    self.midRect   = CGRectMake(0, 0, rect.size.width, rect.size.height / 2.f);
    self.endRect   = CGRectMake(0, -5, rect.size.width, rect.size.height / 2.f);
}

/**
 *  重置UIImageView的参数
 */
- (void)resetImageView {
    
    self.imageView.alpha = 0.f;
    self.imageView.frame = self.startRect;
}

/**
 *  显示出来
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated {
    
    [self resetImageView];
    
    if (animated) {
        
        [UIView animateWithDuration:duration animations:^{
            
            self.imageView.frame = self.midRect;
            self.imageView.alpha = 1.f;
        }];
        
    } else {
        
        self.imageView.frame = self.midRect;
        self.imageView.alpha = 1.f;
    }
}

/**
 *  隐藏
 *
 *  @param duration 动画持续时间
 *  @param animated 是否执行动画
 */
- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated {
    
    if (animated) {
        
        [UIView animateWithDuration:duration animations:^{
            self.imageView.frame = self.endRect;
            self.imageView.alpha = 0.f;
        }];
        
    } else {
        
        self.imageView.frame = self.endRect;
        self.imageView.alpha = 0.f;
    }
}

@synthesize image = _image;

- (UIImage *)image {
    
    return _image;
}

- (void)setImage:(UIImage *)image {
    
    _image               = image;
    self.imageView.image = image;
}

@end
