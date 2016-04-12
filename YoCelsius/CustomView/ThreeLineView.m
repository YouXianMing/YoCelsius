//
//  ThreeLineView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ThreeLineView.h"

#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

@interface ThreeLineView ()

@property (nonatomic, strong) AnimatedLineView  *oneLine;
@property (nonatomic, strong) AnimatedLineView  *twoLine;
@property (nonatomic, strong) AnimatedLineView  *threeLine;

@end

@implementation ThreeLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initLineViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)initLineViews {
    
    UIImage *image = [UIImage imageNamed:@"WindSpeed"];
    CGFloat  width = self.height / image.size.height * image.size.width / 2.f;
    
    // 初始化第一个叶子
    self.oneLine        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.oneLine.image  = image;
    self.oneLine.center = self.middlePoint;
    [self addSubview:self.oneLine];

    // 初始化第二个叶子
    self.twoLine        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.twoLine.image  = image;
    self.twoLine.center = self.middlePoint;
    [self addSubview:self.twoLine];
    self.twoLine.transform = CGAffineTransformRotate(self.twoLine.transform, RADIAN(120));

    // 初始化第三个叶子
    self.threeLine        = [[AnimatedLineView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.threeLine.image  = image;
    self.threeLine.center = self.middlePoint;
    [self addSubview:self.threeLine];
    self.threeLine.transform = CGAffineTransformRotate(self.threeLine.transform, RADIAN(240));
}

- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated {
    
    [self.oneLine   showWithDuration:duration animated:animated];
    [self.twoLine   showWithDuration:duration animated:animated];
    [self.threeLine showWithDuration:duration animated:animated];
}

- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated {
    
    [self.oneLine   hideWithDuration:duration animated:animated];
    [self.twoLine   hideWithDuration:duration animated:animated];
    [self.threeLine hideWithDuration:duration animated:animated];
}

- (void)rotateImageViewWithCircleByOneSecond {
        
    CGFloat circleByOneSecond = (self.circleByOneSecond <= 0 ? 0.001 : self.circleByOneSecond);

    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue         = @(0);
    rotationAnimation.toValue           = @(M_PI * 100000);
    rotationAnimation.duration          = (1 / circleByOneSecond) * 100000;
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)eventDidBecomeActive:(id)obj {
    
    // 获取通知对象
    NSNotification *fication = obj;

    if ([fication.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 1.f;
        }];
        
        [self rotateImageViewWithCircleByOneSecond];
        
    } else if ([fication.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 0.f;
        }];
        
    } else if ([fication.name isEqualToString:UIApplicationWillResignActiveNotification]) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.alpha = 0.f;
        }];
    }
}

@end
