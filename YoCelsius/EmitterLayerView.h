//
//  EmitterLayerView.h
//  TestCAEmitterLayer
//
//  Created by YouXianMing on 14/10/17.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    __SNOW = 0x11,
    __RAIN,
    __NONE,
    
} EMitterType;

@interface EmitterLayerView : UIView

/**
 * 重写setter，getter方法，可以在程序中直接使用点语法
 */
- (void)setEmitterLayer:(CAEmitterLayer *)layer;
- (CAEmitterLayer *)emitterLayer;

/**
 *  CAEmitterLayer参数详解
 
 emitterCells 
 附着在当前layer上的粒子的数组，每一个元素必须是CAEmitterCell对象
 
 [支持动画] birthRate
 每秒钟生成粒子的速率，默认值是1，其作为乘积器影响emitterCells中的对象
 
 [支持动画] lifetime
 粒子的生命周期，默认值为1，其作为乘积器影响emitterCells中的对象
 
 [支持动画] emitterPosition emitterZPosition
 发射器中心位置，默认值为(0, 0, 0)
 
 [支持动画] emitterSize emitterDepth
 发射器尺寸的大小，默认值为(0, 0, 0)，根据emitterPosition与emitterZPosition值的不同，会导致部分值失效
 
 [支持动画] velocity
 粒子的速率，默认值为1，其作为乘积器影响emitterCells中的对象
 
 [支持动画] scale
 粒子的尺寸，默认值为1，其作为乘积器影响emitterCells中的对象
 
 [支持动画] spin
 粒子的旋转，默认值为1，其作为乘积器影响emitterCells中的对象
 
 emitterShape
 发射器的形状类型，包括以下这几种'point'(默认值),'line','rectangle','circle','cuboid'与'sphere'
 
 emitterMode
 发射器模式，包括以下几种'points','outline','surface'与'volume'(默认值)
 
 renderMode
 渲染模式
 
 preservesDepth
 景深模式开关，默认为NO
 */


/*
 CAEmitterCell类代从从CAEmitterLayer射出的粒子；
 emitter cell定义了粒子发射的方向。
 
 alphaRange:  一个粒子的颜色alpha能改变的范围；
 
 alphaSpeed:粒子透明度在生命周期内的改变速度；
 
 birthrate：粒子参数的速度乘数因子；
 
 blueRange：一个粒子的颜色blue 能改变的范围；
 
 blueSpeed: 粒子blue在生命周期内的改变速度；
 
 color:粒子的颜色
 
 contents：是个CGImageRef的对象,既粒子要展现的图片；
 
 contentsRect：应该画在contents里的子rectangle：
 
 emissionLatitude：发射的z轴方向的角度
 
 emissionLongitude:x-y平面的发射方向
 
 emissionRange；周围发射角度
 
 emitterCells：粒子发射的粒子
 
 enabled：粒子是否被渲染
 
 greenrange: 一个粒子的颜色green 能改变的范围；
 
 greenSpeed: 粒子green在生命周期内的改变速度；
 
 lifetime：生命周期
 
 lifetimeRange：生命周期范围
 
 magnificationFilter：不是很清楚好像增加自己的大小
 
 minificatonFilter：减小自己的大小
 
 minificationFilterBias：减小大小的因子
 
 name：粒子的名字
 
 redRange：一个粒子的颜色red 能改变的范围；
 
 redSpeed; 粒子red在生命周期内的改变速度；
 
 scale：缩放比例：
 
 scaleRange：缩放比例范围；
 
 scaleSpeed：缩放比例速度：
 
 spin：子旋转角度
 
 spinrange：子旋转角度范围
 
 style：不是很清楚：
 
 velocity：速度
 
 velocityRange：速度范围
 
 xAcceleration:粒子x方向的加速度分量
 
 yAcceleration:粒子y方向的加速度分量
 
 zAcceleration:粒子z方向的加速度分量
 Class Methods
 
 defauleValueForKey: 更具健获得值；
 
 emitterCell：初始化方法
 
 shouldArchiveValueForKey:是否归档莫键值
 
 */

- (void)show;
- (void)hide;
- (void)configType:(EMitterType)type;

@end
