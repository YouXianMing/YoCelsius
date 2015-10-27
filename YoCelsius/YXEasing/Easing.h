//
//  Easing.h
//  Easing
//
//  Created by YouXianMing on 14-10-10.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#ifndef __Easing__Easing__
#define __Easing__Easing__

#include <stdio.h>
#include <math.h>

#if defined(__LP64__) && !defined(AH_EASING_USE_DBL_PRECIS)
#define AH_EASING_USE_DBL_PRECIS
#endif

#ifdef AH_EASING_USE_DBL_PRECIS
#define AHFloat double
#else
#define AHFloat float
#endif

// 函数指针
typedef AHFloat (*AHEasingFunction)(AHFloat);

// Linear interpolation (no easing)
AHFloat LinearInterpolation(AHFloat p);

// Quadratic easing; p^2
AHFloat QuadraticEaseIn(AHFloat p);
AHFloat QuadraticEaseOut(AHFloat p);
AHFloat QuadraticEaseInOut(AHFloat p);

// Cubic easing; p^3
AHFloat CubicEaseIn(AHFloat p);
AHFloat CubicEaseOut(AHFloat p);
AHFloat CubicEaseInOut(AHFloat p);

// Quartic easing; p^4
AHFloat QuarticEaseIn(AHFloat p);
AHFloat QuarticEaseOut(AHFloat p);
AHFloat QuarticEaseInOut(AHFloat p);

// Quintic easing; p^5
AHFloat QuinticEaseIn(AHFloat p);
AHFloat QuinticEaseOut(AHFloat p);
AHFloat QuinticEaseInOut(AHFloat p);

// Sine wave easing; sin(p * PI/2)
AHFloat SineEaseIn(AHFloat p);
AHFloat SineEaseOut(AHFloat p);
AHFloat SineEaseInOut(AHFloat p);

// Circular easing; sqrt(1 - p^2)
AHFloat CircularEaseIn(AHFloat p);
AHFloat CircularEaseOut(AHFloat p);
AHFloat CircularEaseInOut(AHFloat p);

// Exponential easing, base 2
AHFloat ExponentialEaseIn(AHFloat p);
AHFloat ExponentialEaseOut(AHFloat p);
AHFloat ExponentialEaseInOut(AHFloat p);

// Exponentially-damped sine wave easing
AHFloat ElasticEaseIn(AHFloat p);
AHFloat ElasticEaseOut(AHFloat p);
AHFloat ElasticEaseInOut(AHFloat p);

// Overshooting cubic easing;
AHFloat BackEaseIn(AHFloat p);
AHFloat BackEaseOut(AHFloat p);
AHFloat BackEaseInOut(AHFloat p);

// Exponentially-decaying bounce easing
AHFloat BounceEaseIn(AHFloat p);
AHFloat BounceEaseOut(AHFloat p);
AHFloat BounceEaseInOut(AHFloat p);



#endif /* defined(__Easing__Easing__) */
