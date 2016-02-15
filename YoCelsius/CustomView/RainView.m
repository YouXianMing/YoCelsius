//
//  RainView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "RainView.h"

@implementation RainView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.emitterLayer.emitterShape    = kCAEmitterLayerLine;                            // 直线粒子发射器
    self.emitterLayer.emitterMode     = kCAEmitterLayerSurface;                         // ?????
    self.emitterLayer.emitterSize     = self.frame.size;                                // 发射区域
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width / 2.f, - 5); // 发射中心点位置
}

- (void)showSnow {
    
    // 创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    // 粒子的名字
    snowflake.name = @"snow";
    
    // 粒子参数的速度乘数因子
    snowflake.birthRate = (_birthRate > 0 ? _birthRate : 1.f);
    
    // 粒子生命周期
    snowflake.lifetime = (_lifetime > 0 ? _lifetime : 60);
    
    // 粒子速度
    snowflake.velocity = (_speed > 0 ? _speed : 10.f);
    
    // 粒子的速度范围
    snowflake.velocityRange = (_speedRange > 0 ? _speedRange : 10.f);
    
    // 粒子y方向的加速度分量(可以理解为重力)
    snowflake.yAcceleration = (_gravity != 0 ? _gravity : 2.f);
    
    // 每个发射的粒子的初始时候随机的角度
    snowflake.emissionRange = 0.f * M_PI;
    
    // 获取图片
    snowflake.contents = (id)_snowImage.CGImage;
    
    // 设置雪花形状的粒子的颜色
    snowflake.color = (_snowColor == nil ? [[UIColor whiteColor] CGColor] :_snowColor.CGColor);
    
    // 尺寸
    snowflake.scale = 0.2;
    
    // 尺寸变化范围
    snowflake.scaleRange = 0.3f;
    
    // 添加粒子
    self.emitterLayer.emitterCells = @[snowflake];
}

- (void)configType:(EMitterType)type {
    
    if (type == __RAIN) {
        
        UIImageView *snowAlpha = [[UIImageView alloc] initWithFrame:self.bounds];
        snowAlpha.image        = [UIImage imageNamed:@"alpha"];
        self.maskView          = snowAlpha;

        // 配置
        self.birthRate = 100.f;
        self.speed     = 10.f;
        self.gravity   = 2000.f;
        self.snowImage = [UIImage imageNamed:@"rain"];
        self.snowColor = [UIColor blackColor];
        self.lifetime  = 1.f;
        self.maskView  = snowAlpha;
        self.alpha     = 0.f;
    }
}

- (void)show {
    
    [self showSnow];
    
    [UIView animateWithDuration:1.75f animations:^{
        
        self.alpha = 0.5f;
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.75 animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
