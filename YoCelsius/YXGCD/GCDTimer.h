//
//  GCDTimer.h
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

@class GCDQueue;
@interface GCDTimer : NSObject

@property (STRONG, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化以及释放
- (instancetype)init;
- (instancetype)initInQueue:(GCDQueue *)queue;
- (void)dispatchRelease;

#pragma 用法
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)start;
- (void)destroy;


@end
