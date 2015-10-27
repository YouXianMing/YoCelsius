//
//  GCDSemaphore.h
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define STRONG strong
#else
#define STRONG retain
#endif

@interface GCDSemaphore : NSObject

@property (STRONG, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化以及释放
- (instancetype)init;
- (instancetype)initWithValue:(long)value;
- (void)dispatchRelease;

#pragma 用法
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
